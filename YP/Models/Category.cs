using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Category
{
    public string? Name { get; set; }

    public int Id { get; set; }

    public virtual ICollection<Subcategory> Subcategories { get; set; } = new List<Subcategory>();
}
