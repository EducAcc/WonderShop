using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Size
{
    public double Name { get; set; }

    public virtual ICollection<OrderProduct> OrderProducts { get; set; } = new List<OrderProduct>();

    public virtual ICollection<Stock> Stocks { get; set; } = new List<Stock>();
}
