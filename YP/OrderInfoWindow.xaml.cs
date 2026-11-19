using MaterialDesignThemes.Wpf.Behaviors.Internal;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using YP.Models;

namespace WonderShoe
{
    /// <summary>
    /// Логика взаимодействия для OrderInfoWindow.xaml
    /// </summary>
    public partial class OrderInfoWindow : Window, INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        Order _order
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged(nameof(OrderDate));
            }
        }
        int _orderId;

        public DateTime? OrderDate
        {
            get => _order?.Date?.ToDateTime(TimeOnly.MinValue);
            set
            {
                _order?.Date = value.HasValue ?
                    DateOnly.FromDateTime(value.Value) : null;
                OnPropertyChanged();
            }
        }
        public OrderProduct SelectedProduct
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }
        public bool IsEditibleMode
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }
        public DateTime StartDate { get; } = DateTime.Today.AddYears(-40);
        public DateTime EndDate { get; } = DateTime.Today;

        public ObservableCollection<OrderProduct> Products
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }

        public OrderInfoWindow(int? orderId = null, bool isEditibleMode = true)
        {
            InitializeComponent();

            _orderId = orderId ?? 0;
            IsEditibleMode = isEditibleMode;

            Loaded += OnWindow_Loaded;
            DataContext = this;
        }

        private void AddProductBtn_Click(object sender, RoutedEventArgs e)
        {

        }

        private async void DeleteProductBtn_Click(object sender, RoutedEventArgs e)
        {
            if (SelectedProduct != null)
            {
                using (var db = new ShoeShopContext())
                {
                    try
                    {
                        MessageBoxResult userResponse = MessageBox.Show("Удалить товар из заказа",
                            "Удаление товара из заказа", MessageBoxButton.YesNo);

                        if (userResponse == MessageBoxResult.Yes)
                        {
                            db.OrderProducts.Remove(SelectedProduct);
                            Products.Remove(SelectedProduct);
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Ошибка при удалении товара: {ex.InnerException?.Message ?? ex.Message}");
                    }
                }
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            using (var db = new ShoeShopContext())
            {
                try
                {
                    if (OrderDate == null
                        || OrderDate < StartDate
                        || OrderDate > EndDate)
                    {
                        MessageBox.Show("Выберите корректную дату");
                        return;
                    }

                    db.SaveChanges();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка сохранении данных: {ex.InnerException?.Message ?? ex.Message}");
                }
            }
        }

        private async void OnWindow_Loaded(object sender, RoutedEventArgs e)
        {
            Loaded -= OnWindow_Loaded;

            using (var db = new ShoeShopContext())
            {
                Products = new ObservableCollection<OrderProduct>(db.OrderProducts
                    .AsNoTracking()
                    .Where(o => o.OrderId == _orderId)
                    .Include(op => op.Order)
                    .Include(op => op.Product)
                        .ThenInclude(p => p.Manufacturer)
                    .Include(op => op.Product)
                        .ThenInclude(p => p.Subcategory)
                            .ThenInclude(s => s.Category)
                    .ToList());

                _order = db.Orders.FirstOrDefault(o => o.Id == _orderId) ?? new Order();
            }
        }

        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
