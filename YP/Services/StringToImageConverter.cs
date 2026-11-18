using System;
using System.Collections.Generic;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows.Data;
using System.Windows.Media.Imaging;

namespace WonderShoe.Services
{
    // Класс конвертер для преобразования названия изображения из бд в путь до этого изображения

    // Можно было еще попытаться наследовать его от MarkupExtension, чтобы не объявлять в ресурсах формы
    internal class StringToImageConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string uriPath = $"pack://application:,,,/Images/";
            string finalPath;

            if (value is string imageName && !string.IsNullOrWhiteSpace(imageName))
            {
                finalPath = uriPath + imageName;
            }
            else
            {
                finalPath = uriPath + (parameter is string paramStr ? paramStr : "picture.png");
            }

            return new BitmapImage(new Uri(finalPath, UriKind.Absolute));
        }

        public object ConvertBack(object type, Type targetType, object parameter, CultureInfo culture)
        {
            return new NotImplementedException();
        }
    }
}
