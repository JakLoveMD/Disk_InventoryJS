using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
            List<Disk> disk = context.Disk.OrderBy(a => a.DiskName).Include(g => g.Genre).Include(s => s.Status).Include(t =>t.DiskType).ToList();
            return View(disk);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.GenreTypes = context.Genre.OrderBy(t => t.Description).ToList();
            ViewBag.StatusTypes = context.Status.OrderBy(a => a.Description).ToList();
            ViewBag.DiskTypes = context.DiskType.OrderBy(b => b.Description).ToList();
            return View("Edit", new Disk());
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.GenreTypes = context.Genre.OrderBy(t => t.Description).ToList();
            ViewBag.StatusTypes = context.Status.OrderBy(a => a.Description).ToList();
            ViewBag.DiskTypes = context.DiskType.OrderBy(b => b.Description).ToList();
            var disk = context.Disk.Find(id);
            return View(disk);
        }

        [HttpPost]
        public IActionResult Edit(Disk disk)
        {
            if (ModelState.IsValid)
            {
                if (disk.DiskId == 0)
                    context.Disk.Add(disk);
                else
                    context.Disk.Update(disk);
                context.SaveChanges();
                return RedirectToAction("List", "Disk");
            }
            else
            {
                ViewBag.Action = (disk.DiskId == 0) ? "Add" : "Edit";
                ViewBag.GenreTypes = context.Genre.OrderBy(t => t.Description).ToList();
                ViewBag.StatusTypes = context.Status.OrderBy(a => a.Description).ToList();
                ViewBag.DiskTypes = context.DiskType.OrderBy(b => b.Description).ToList();
                return View(disk);
            }
        }

        [HttpGet]
        public IActionResult Delete(int id)
        {
            var disk = context.Disk.Find(id);
            return View(disk);
        }

        [HttpPost]
        public IActionResult Delete(Disk disk)
        {
            context.Disk.Remove(disk);
            context.SaveChanges();
            return RedirectToAction("List", "Disk");
        }
    }
}
