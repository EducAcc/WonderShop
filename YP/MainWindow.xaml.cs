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

namespace WonderShoe
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        public User User
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(IsUserAdminOrManager));
            }
        }

        public bool IsUserAdminOrManager
        {
            get => User?.RoleId == 1 || User?.RoleId == 2;
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
                using (var db = new ShoeShopContext())
                {
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
                
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при обращении к бд: {ex.InnerException?.Message ?? ex.Message}");
            }
        }

        private void ShowOrderInfoDialog(int? orderId = null, bool isEditibleMode = false)
        {
            var orderInfoWindow = new OrderInfoWindow(User.Id, orderId, isEditibleMode);
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
                CatalogControl.User = User;
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
}