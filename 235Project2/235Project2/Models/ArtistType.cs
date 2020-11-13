﻿using System;
using System.Collections.Generic;

namespace _235Project2.Models
{
    public partial class ArtistType
    {
        public ArtistType()
        {
            Artist = new HashSet<Artist>();
        }

        public int ArtistTypeId { get; set; }
        public string Description { get; set; }

        public virtual ICollection<Artist> Artist { get; set; }
    }
}
