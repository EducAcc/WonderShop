using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
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

namespace YP
{
    /// <summary>
    /// Логика взаимодействия для AuthWindow.xaml
    /// </summary>
    public partial class AuthWindow : Window, INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        public User CurrentUser { get; private set; }
        public string Login
        {
            get;
            set
            {
                field = value;
                OnPropertyChanged();
            }
        }

        public AuthWindow()
        {
            InitializeComponent();

            // Должен чинить задержку при проверке логина (Чинит!)
            Task.Run(() =>
            {
                try
                {
                    using (var db = new ShoeShopContext())
                    {
                        _ = db.Users
                            .AsNoTracking()
                            .FirstOrDefault(u => false);
                    }
                }
                catch { }
            });

            #if DEBUG
                Login = "admin";
                ApplyBtn_Click(this, new RoutedEventArgs());
            #endif

            DataContext = this;
        }

        private async void ApplyBtn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (var db = new ShoeShopContext())
                {
                    User userFromDb = await db.Users
                        .AsNoTracking()
                        .FirstOrDefaultAsync(u => u.Login == Login);

                    if (userFromDb == null)
                    {
                        MessageBox.Show("Нет пользователя с таким логином");
                        return;
                    }

                    CurrentUser = userFromDb;
                    DialogResult = true;
                    Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при обращении к бд: {ex.InnerException?.Message ?? ex.Message}");
            }
        }


        protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
