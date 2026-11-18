using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Product
{
    public int SubcategoryId { get; set; }

    public string? Img { get; set; }

    public string? Name { get; set; }

    public int? ManufacturerId { get; set; }

    public string? Description { get; set; }

    public string? Content { get; set; }

    public double? Price { get; set; }

    public int Id { get; set; }

    public virtual Manufacturer? Manufacturer { get; set; }

    public virtual ICollection<OrderProduct> OrderProducts { get; set; } = new List<OrderProduct>();

    public virtual ICollection<Stock> Stocks { get; set; } = new List<Stock>();

    public virtual Subcategory Subcategory { get; set; } = null!;
}
