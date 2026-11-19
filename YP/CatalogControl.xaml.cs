using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Reflection.Metadata;
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

namespace WonderShoe
{
    /// <summary>
    /// Логика взаимодействия для CatalogControl.xaml
    /// </summary>
    public partial class CatalogControl : UserControl, INotifyPropertyChanged
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
        public bool IsCartContainItem
        {
            get => Cart.Count > 0;
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

        public event PropertyChangedEventHandler? PropertyChanged;

        public CatalogControl()
        {
            InitializeComponent();

            DataContext = this;
            Loaded += CatalogControl_Loaded;
        }

        private async Task OnStart()
        {
            try
            {
                var products = await GetProducts();

                Products = new ObservableCollection<Product>(products);
                // Для списка продуктов создается его копия, которая будет отображаться на форме.
                // Благодаря этому можно написать метод-фильтр и не изменять список вручную, а просто скрывать
                // Те элементы, которые не проходят фильтр
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
                }
                ;
            }
            catch (Exception ex)
            {
                error = $"Ошибка при записи в бд: {ex.InnerException?.Message ?? ex.Message}";
                return false;
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

                //Hide();

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

                //Show();
            }
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

        private async void CatalogControl_Loaded(object sender, RoutedEventArgs e)
        {
            Loaded -= CatalogControl_Loaded;

            await OnStart();
        }

        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
