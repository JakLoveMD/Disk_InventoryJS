using System;
using System.Collections.Generic;

namespace _235Project2.Models
{
    public partial class DiskType
    {
        public DiskType()
        {
            Disk = new HashSet<Disk>();
        }

        public int DiskTypeId { get; set; }
        public string Description { get; set; }

        public virtual ICollection<Disk> Disk { get; set; }
    }
}
