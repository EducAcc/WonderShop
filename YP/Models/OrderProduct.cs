using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class OrderProduct
{
    public int OrderId { get; set; }

    public int ProductId { get; set; }

    public double? Size { get; set; }

    public int? Quantity { get; set; }

    public double? Price { get; set; }

    public double? Total { get; protected set; }


    public int Id { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;

    public virtual Size? SizeNavigation { get; set; }
}
