using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using Microsoft.VisualBasic;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Security.Policy;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Converters;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using YP;
using YP.Models;
using Size = YP.Models.Size;

namespace WonderShoe
{
    /// <summary>
    /// Логика взаимодействия для ProductInfoWindow.xaml
    /// </summary>
    public partial class ProductInfoWindow : Window, INotifyPropertyChanged
    {
        public Product Product
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }
        public int Quantity
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged(nameof(QuantityText));
            }
        }
        public string QuantityText
        {
            get => Quantity.ToString();
            set
            {
                if (int.TryParse(value, out int result))
                {
                    Quantity = result;
                    OnPropertyChanged();
                }
            }
        }
        public double SelectedSize { get; private set; }
        public ObservableCollection<SizeWrap> Sizes
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }

        public event PropertyChangedEventHandler? PropertyChanged;

        public ProductInfoWindow(int id, double? price)
        {
            InitializeComponent();

            try
            {
                using (var db = new ShoeShopContext())
                {
                    Product = db.Products
                        .AsNoTracking()
                        .Include(p => p.Subcategory)
                            .ThenInclude(s => s.Category)
                        .Include(p => p.Manufacturer)
                        .Include(p => p.Stocks)
                        .First(p => p.Id == id);

                    Product.Price = price;

                    Sizes = new ObservableCollection<SizeWrap>(db.Stocks
                        .AsNoTracking()
                        .Where(s => s.ProductId == id)
                        .GroupBy(s => s.Size)
                        .Select(g => new SizeWrap(
                            g.First().SizeNavigation,
                            g.Sum(s => s.Quantity)
                            ))
                        .ToList());
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при обращении к бд: {ex.InnerException?.Message ?? ex.Message}");
            }

            DataContext = this;
        }

        private void SizeBtnClick_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try
            {
                double selectedSize = Convert.ToDouble((sender as Border).Tag);

                if (SelectedSize != selectedSize)
                {
                    foreach (var size in Sizes)
                    {
                        size.IsSelected = false;

                        if (size.Size.Name == selectedSize)
                        {
                            size.IsSelected = true;
                        }
                    }

                    SelectedSize = selectedSize;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при выборе размера, попробуйте выбрать другой: {ex.Message}");
            }
        }

        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void AddToCartBtn_Click(object sender, RoutedEventArgs e)
        {
            if (SelectedSize <= 0)
            {
                MessageBox.Show("Выберите размер обуви");
                return;
            }
            else if (Quantity <= 0)
            {
                MessageBox.Show("Кол-во должно быть больше нуля, введите корретное значение");
                return;
            }

            DialogResult = true;
            Close();
        }
    }

    public class SizeWrap : INotifyPropertyChanged
    {
        public Size Size { get; set; }
        public int? Quantity { get; set; }
        public bool IsSelected 
        { 
            get; 
            set
            {
                field = value;
                OnPropertyChanged();
            } 
        }

        public event PropertyChangedEventHandler? PropertyChanged;


        public SizeWrap(Size size, int? quantity)
        {
            Size = size;
            Quantity = quantity;
        }

        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

    }
}
