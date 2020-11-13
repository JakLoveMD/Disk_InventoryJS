using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using _235Project2.Models;

namespace _235Project2.Controllers
{
    public class BorrowerController : Controller
    {
        private disk_invjsContext context { get; set; }
        public BorrowerController(disk_invjsContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Borrower> borrower = context.Borrower.OrderBy(a => a.Lname).ToList();
            return View(borrower);
        }
    }
}
