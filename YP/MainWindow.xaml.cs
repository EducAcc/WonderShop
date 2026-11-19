using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Globalization;
using System.Net;
using System.Runtime.CompilerServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using YP.Models;
using WonderShoe;
using MaterialDesignThemes.Wpf.Converters;

namespace YP
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        private int DiscountPercent = 25;

        public User User
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(IsUserLogin));
                OnPropertyChanged(nameof(IsUserAdminOrManager));
            }
        }
        public string SearchProduct
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();

                ProductsView?.Refresh();
            }
        }
        public double CartTotal
        {
            get => Cart.Sum(p => p.Price * p.Quantity) ?? 0;
        }
        public bool IsUserLogin
        {
            get => User != null;
        }
        public bool IsUserAdminOrManager
        {
            get => User?.RoleId == 1 || User?.RoleId == 2;
        }
        public bool IsCartContainItem
        {
            get => Cart.Count > 0;
        }
        public Order SelectedOrder
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }

        public ObservableCollection<Product> Products
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }
        public ICollectionView ProductsView { get; set; }
        public ObservableCollection<OrderProduct> Cart
        {
            get;
            private set
            {
                field = value;
                OnPropertyChanged();
            }
        } = new ObservableCollection<OrderProduct>();
        public ObservableCollection<Order> Orders
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }

        public event PropertyChangedEventHandler? PropertyChanged;

        public MainWindow()
        {
            InitializeComponent();

            DataContext = this;
        }


        private async Task OnStart()
        {
            try
            {
                var products = await GetProducts();

                Products = new ObservableCollection<Product>(products);
                ProductsView = CollectionViewSource.GetDefaultView(Products);
                // Подключение метода для фильтрации элементов в списке. Проверяет каждый фильтр по методу
                ProductsView.Filter = FilterProducts;

                using (var db = new ShoeShopContext())
                {
                    var categories = await db.Categories
                        .AsNoTracking()
                        .ToListAsync();

                    categories.Insert(0, new Category { Name = "Все категории" });

                    CategoryCombo.ItemsSource = categories;

                    Orders = new ObservableCollection<Order>(await db.Orders
                        .AsNoTracking()
                        .Include(o => o.User)
                        .Include(o => o.OrderProducts)
                            .ThenInclude(op => op.SizeNavigation)
                        .Include(o => o.OrderProducts)
                            .ThenInclude(op => op.Product)
                            .ThenInclude(p => p.Manufacturer)
                        .ToListAsync());
                }

                await DetermineDiscountes(products);

                // Когда в коризну добавяется элемент, вызывает обновление IsCartContainItem
                // И CartTotal. Прописать им OnPropertyChanged я не могу, потому что в них есть только геттер
                Cart.CollectionChanged += (sender, e) =>
                {
                    OnPropertyChanged(nameof(IsCartContainItem));
                    OnPropertyChanged(nameof(CartTotal));
                };
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при обращении к бд: {ex.InnerException?.Message ?? ex.Message}");
            }
        }

        private void UpdateDiscountedProductsPrice(List<Product> products)
        {
            products.ForEach(p => p.Price = p.Price - p.Price * (DiscountPercent / 100.0));
        }

        private List<Product> GetDiscountedProducts(List<OrderProduct> ordersProducts, List<Product> allProducts)
        {
            // Товары, которые были заказны
            var orderedProducts = ordersProducts
                .DistinctBy(o => o.ProductId)
                .Select(o => o.Product);

            // Товары, которые не были заказаны
            // Из общего списка товаров выбираются те, что отсутствуют в orderedProducts
            return allProducts.ExceptBy(
                    orderedProducts.Select(p => p.Id),
                    p => p.Id
                ).ToList();
        }

        private async Task DetermineDiscountes(List<Product> allProducts)
        {

            List<OrderProduct> orderProducts;

            DateOnly today = new DateOnly(DateTime.Today.Year, DateTime.Today.Month, 1);
            DateOnly monthBeforeToday = today.AddMonths(-1);

            using (var db = new ShoeShopContext())
            {
                orderProducts = await db.OrderProducts
                    .AsNoTracking()
                    .Include(o => o.Order)
                    .Include(o => o.Product)
                    .Where(o => o.Order.Date >= monthBeforeToday && o.Order.Date < today)
                    .ToListAsync();
            }

            List<Product> discountedProducts = GetDiscountedProducts(orderProducts, allProducts);
            
            UpdateDiscountedProductsPrice(discountedProducts);
        }

        private async Task<List<Product>> GetProducts()
        {
            using (var db = new ShoeShopContext())
            {
                return await db.Products
                    .AsNoTracking()
                    .Include(p => p.Subcategory)
                        .ThenInclude(s => s.Category)
                    .Include(p => p.Manufacturer)
                    .Include(p => p.Stocks)
                    .ToListAsync();
            }
        }

        // Метод для фильтрации списка продуктов (поиск, фильтр)
        // Работает только с ICollectionView
        private bool FilterProducts(object obj)
        {
            if (obj is not Product product || product == null) return false;

            string searchStr = SearchProduct?.ToLower().Trim() ?? "";
            if (!product.Name.ToLower().Contains(searchStr)) return false;

            int selectedCategoryId = (CategoryCombo?.SelectedItem as Category)?.Id ?? 0;
            if (selectedCategoryId != 0 &&
                product.Subcategory.Category.Id != selectedCategoryId)
            {
                return false;
            }

            return true;
        }

        private bool FormOrder(List<OrderProduct> products, out string error)
        {
            try
            {
                using (var db = new ShoeShopContext())
                {
                    List<OrderProduct> orderProducts = products
                        .Select(p => new OrderProduct()
                        {
                            ProductId = p.ProductId,
                            Quantity = p.Quantity,
                            Size = p.Size,
                            Price = p.Price
                        }).ToList();

                    var newOrder = new Order()
                    {
                        Date = DateOnly.FromDateTime(DateTime.Today),
                        OrderProducts = orderProducts,
                        UserId = User.Id
                    };

                    db.Orders.Add(newOrder);
                    db.SaveChanges();
                    error = "";

                    return true;
                };
            }
            catch (Exception ex)
            {
                error = $"Ошибка при записи в бд: {ex.InnerException?.Message ?? ex.Message}";
                return false;
            }
        }

        private void ShowOrderInfoDialog(int? orderId = null, bool isEditibleMode = false)
        {
            var orderInfoWindow = new OrderInfoWindow(orderId, isEditibleMode);
            orderInfoWindow.Owner = this;
            orderInfoWindow.WindowStartupLocation = WindowStartupLocation.CenterOwner;

            orderInfoWindow.ShowDialog();
        }

        private void LoginBtn_Click(object sender, RoutedEventArgs e)
        {
            var authWindow = new AuthWindow();
            authWindow.Owner = this;
            authWindow.WindowStartupLocation = WindowStartupLocation.CenterOwner;

            if (authWindow.ShowDialog() == true)
            {
                User = authWindow.CurrentUser;
            }
        }
        private void WipeCartBtn_Click(object sender, RoutedEventArgs e)
        {
            Cart.Clear();
        }
        private async void ApplyOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            if (Cart.Count < 0)
            {
                MessageBox.Show("Выберите товар для заказа");
                return;
            }

            if (!FormOrder(Cart.ToList(), out string message))
            {
                MessageBox.Show(message);
                return;
            }

            await DetermineDiscountes(Products.ToList());
            MessageBox.Show("Заказ оформлен");
        }
        private void DeleteCartElementBtn_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button)
            {
                if (button.DataContext is OrderProduct item)
                {
                    var result = MessageBox.Show("Удалить товар из корзины?", "Удаление товара", MessageBoxButton.YesNo);

                    if (result == MessageBoxResult.Yes)
                    {
                        Cart.Remove(item);
                    }
                }
            }
        }
        private void AddOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            // Метод принимает 2 аргумента: первый - id заказа и bool в качестве мода
            // Если true - значит зашел админ , false - менеджер
            var isAdmin = User.RoleId == 1;
            ShowOrderInfoDialog(isEditibleMode: isAdmin);
        }
        private void DeleteOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            if (SelectedOrder == null)
            {
                MessageBox.Show("Выберите заказ для удаления");
                return;
            }

            var userResponse = MessageBox.Show("Удалить выбранный заказ?", "Подтверждение удаления", MessageBoxButton.YesNo);

            if (userResponse == MessageBoxResult.Yes)
            {
                try
                {
                    using (var db = new ShoeShopContext())
                    {
                        db.Orders.Remove(SelectedOrder);

                        db.SaveChanges();

                        Orders.Remove(SelectedOrder);

                        MessageBox.Show("Заказ удален");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при удалении данных: {ex.InnerException?.Message ?? ex.Message}");
                }
            }
        }

        private void CardClick_MouseDown(object sender, MouseButtonEventArgs e)
        {
            // Если пользователь не авторизован, открыть карточку товара он не сможет
            if (!IsUserLogin)
            {
                return;
            }

            var card = sender as Border;

            if (card != null)
            {
                int productId = (int)card.Tag;
                var selectedProduct = Products.First(p => p.Id == productId);

                var productInfoWindow = new ProductInfoWindow(productId, selectedProduct.Price);

                Hide();

                if (productInfoWindow.ShowDialog() == true)
                {
                    Cart.Add(new OrderProduct()
                    {
                        ProductId = productId,
                        Product = selectedProduct,
                        Quantity = productInfoWindow.Quantity,
                        Size = productInfoWindow.SelectedSize,
                        Price = productInfoWindow.Product.Price
                    });
                }

                Show();
            }
        }
        private void OrdersTable_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            var table = sender as DataGrid;

            if (SelectedOrder != null)
            {
                // Здесь в метод всегда передается true, потому что и менеджер и админ
                // должны иметь возможность добавлять новые заказы
                ShowOrderInfoDialog(SelectedOrder.Id, true);
            }

            SelectedOrder = null;
            table.SelectedIndex = -1;
        }

        private void FilterComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string selectedFilter = ((sender as ComboBox).SelectedItem as ComboBoxItem)?.Tag?.ToString() ?? "Asc";

            if (selectedFilter == "Asc")
            {
                Products = new ObservableCollection<Product>(Products.OrderBy(p => p.Price).ToList());
            }
            else if (selectedFilter == "Desc")
            {
                Products = new ObservableCollection<Product>(Products.OrderByDescending(p => p.Price).ToList());
            }
        }
        private void CategoryCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ProductsView?.Refresh();
        }
      
        private async void Window_Loaded(object sender, RoutedEventArgs e)
        {
            Loaded -= Window_Loaded;

            try
            {
                await OnStart();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при получении данных из бд: {ex.InnerException?.Message ?? ex.Message}");
            }
        }
        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }


    // Класс конвертер для получения количества товаров в виде значений "много", "мало"
    // Нужен, потому что данные о количестве находятся в свойстве Stocks, продукта, который представляет собой список
    public class QuantityToStrConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            int quantity = 0;

            if (value is List<Stock> stocks)
            {
                quantity = stocks?.Sum(s => s.Quantity) ?? 0;
            }

            if (quantity > 5)
            {
                return "Много";
            }

            return "Мало";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return new NotImplementedException();
        }
    }

    // Класс конвертер для определения, больше ли количество товара 3 шт, если да - возвращает true, иначе - false
    public class SmallerThanThreeConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            bool result = false;

            if (value is List<Stock> stocks)
            {
                result = (stocks?.Sum(s => s.Quantity) ?? 0) <= 3;
            }

            return result;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return new NotImplementedException();
        }
    }
}