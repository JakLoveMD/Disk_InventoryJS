using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using _235Project2.Models;

namespace _235Project2.Controllers
{
    public class DiskController : Controller
    {
        private disk_invjsContext context { get; set; }
        public DiskController(disk_invjsContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Disk> disk = context.Disk.OrderBy(a => a.DiskName).ToList();
            return View(disk);
        }
    }
}
