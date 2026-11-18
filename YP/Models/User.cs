using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class User
{
    public string? Surname { get; set; }

    public string? Name { get; set; }

    public string? Patronymic { get; set; }

    public string? Login { get; set; }

    public int RoleId { get; set; }

    public int Id { get; set; }

    public string SNP => $"{Surname} {Name} {Patronymic}";

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Role Role { get; set; } = null!;
}
