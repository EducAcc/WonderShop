using System;
using System.Collections.Generic;

namespace YP.Models;

public partial class Role
{
    public string? Name { get; set; }

    public int Id { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
