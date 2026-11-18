using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Stock
{
    public int ProductId { get; set; }

    public double? Size { get; set; }

    public int? Quantity { get; set; }

    public int Id { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual Size? SizeNavigation { get; set; }
}
