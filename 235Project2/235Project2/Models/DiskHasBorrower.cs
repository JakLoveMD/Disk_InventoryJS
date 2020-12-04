using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations; //Added for project 4

namespace _235Project2.Models
{
    public partial class DiskHasBorrower
    {
        public int Id { get; set; } //Added for project 4
        //[Required(ErrorMessage = "Please enter a Borrower.")]
        public virtual Borrower Borrower { get; set; }
        public int BorrowerId { get; set; }
        [Required(ErrorMessage = "Please enter a Disk.")]
        public int DiskId { get; set; }
        public virtual Disk Disk { get; set; }
        [Required(ErrorMessage = "Please enter a Borrowed Date.")]
        public DateTime BorrowedDate { get; set; }
        public DateTime? ReturnedDate { get; set; }

    }
}
