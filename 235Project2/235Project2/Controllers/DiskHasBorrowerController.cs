using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using _235Project2.Models;

namespace _235Project2.Controllers
{
    public class DiskHasBorrowerController : Controller
    {
        private disk_invjsContext context { get; set; }
        public DiskHasBorrowerController(disk_invjsContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            //  List<DiskHasBorrower> diskhasborrowers = context.DiskHasBorrower.OrderBy(db => db.DiskId).ThenBy(db => db.BorrowerId).ToList();
            var diskhasborrowers = context.DiskHasBorrower.OrderBy(db => db.BorrowedDate).Include(d => d.Disk).OrderBy(d => d.DiskId)
                .Include(b => b.Borrower).OrderBy(b => b.Id).ToList();
            return View(diskhasborrowers);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList();
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.Lname).ToList();
            return View("Edit", new DiskHasBorrower());
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList();
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.Lname).ToList();
            var diskhasborrower = context.DiskHasBorrower.Find(id);
            return View(diskhasborrower);
        }

        [HttpPost]
        public IActionResult Edit(DiskHasBorrower diskHasBorrower)
        {
            if (ModelState.IsValid)
            {
                if (diskHasBorrower.Id == 0)
                    context.DiskHasBorrower.Add(diskHasBorrower);
                else
                    context.DiskHasBorrower.Update(diskHasBorrower);
                context.SaveChanges();
                return RedirectToAction("List", "DiskHasBorrower");
            }
            else
            {
                ViewBag.Action = (diskHasBorrower.Id == 0) ? "Add" : "Edit";
                ViewBag.Disks = context.Disk.OrderBy(t => t.DiskName).ToList();
                ViewBag.Borrowers = context.Borrower.OrderBy(b => b.Lname).ToList();
                return View(diskHasBorrower);
            }
        }
    }
}

