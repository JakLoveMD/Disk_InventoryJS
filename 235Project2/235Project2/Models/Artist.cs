using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace _235Project2.Models
{
    public partial class Artist
    {
        public Artist()
        {
            DiskHasArtist = new HashSet<DiskHasArtist>();
        }

        public int ArtistId { get; set; }
        [Required(ErrorMessage = "Please enter an Artist Name.")]
        public string ArtistName { get; set; }
        public string Description { get; set; }
        [Required(ErrorMessage = "Please choose a Type.")]
        public int ArtistTypeId { get; set; }

        public virtual ArtistType ArtistType { get; set; }
        public virtual ICollection<DiskHasArtist> DiskHasArtist { get; set; }
    }
}
