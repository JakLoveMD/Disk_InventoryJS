﻿using System;
using System.Collections.Generic;

namespace _235Project2.Models
{
    public partial class Genre
    {
        public Genre()
        {
            Disk = new HashSet<Disk>();
        }

        public int GenreId { get; set; }
        public string Description { get; set; }

        public virtual ICollection<Disk> Disk { get; set; }
    }
}
