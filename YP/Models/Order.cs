using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Order
{
    public DateOnly? Date { get; set; }

    public int UserId { get; set; }

    public int Id { get; set; }

    public virtual ICollection<OrderProduct> OrderProducts { get; set; } = new List<OrderProduct>();

    public virtual User User { get; set; } = null!;
}
