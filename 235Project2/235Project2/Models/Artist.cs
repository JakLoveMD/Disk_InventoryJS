using System;
using System.Collections.Generic;

namespace _235Project2.Models
{
    public partial class Artist
    {
        public Artist()
        {
            DiskHasArtist = new HashSet<DiskHasArtist>();
        }

        public int ArtistId { get; set; }
        public string ArtistName { get; set; }
        public string Description { get; set; }
        public int ArtistTypeId { get; set; }

        public virtual ArtistType ArtistType { get; set; }
        public virtual ICollection<DiskHasArtist> DiskHasArtist { get; set; }
    }
}
