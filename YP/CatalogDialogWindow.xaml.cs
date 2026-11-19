using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
    /// Логика взаимодействия для CatalogDialogWindow.xaml
    /// </summary>
    public partial class CatalogDialogWindow : Window
    {
        // Свойство для получения списка товаров из контрола
        public ObservableCollection<OrderProduct> Cart => CatalogControl.Cart;

        public CatalogDialogWindow(User user)
        {
            InitializeComponent();

            CatalogControl.User = user;
        }

        private void AddProductsInOrder_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = true;
            Close();
        }
    }
}
