using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Windows.Data;
using YP.Models;

namespace WonderShoe.Services
{
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
}
