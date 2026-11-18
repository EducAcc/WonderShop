using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Manufacturer
{
    public string? Name { get; set; }

    public int Id { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
