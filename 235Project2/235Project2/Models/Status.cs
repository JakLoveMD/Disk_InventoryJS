﻿using System;
using System.Collections.Generic;

namespace _235Project2.Models
{
    public partial class Status
    {
        public Status()
        {
            Disk = new HashSet<Disk>();
        }

        public int StatusId { get; set; }
        public string Description { get; set; }

        public virtual ICollection<Disk> Disk { get; set; }
    }
}
