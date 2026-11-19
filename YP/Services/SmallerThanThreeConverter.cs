using System;
using System.Collections.Generic;
using System.Globalization;
using System.Runtime.InteropServices.ObjectiveC;
using System.Text;
using System.Windows.Data;
using YP.Models;

namespace WonderShoe.Services
{
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
