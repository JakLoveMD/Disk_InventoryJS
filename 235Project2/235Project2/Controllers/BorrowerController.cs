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
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            return View("Edit", new Borrower());
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            var borrower = context.Borrower.Find(id);
            return View(borrower);
        }
        [HttpPost]
        public IActionResult Edit(Borrower borrower)
        {
            if (ModelState.IsValid)
            {
                if (borrower.BorrowerId == 0)
                    context.Borrower.Add(borrower);
                else
                    context.Borrower.Update(borrower);
                context.SaveChanges();
                return RedirectToAction("List", "Borrower");
            }
            else
            {
                ViewBag.Action = (borrower.BorrowerId == 0) ? "Add" : "Edit";
                return View(borrower);
            }

        }
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var borrower = context.Borrower.Find(id);
            return View(borrower);
        }
        [HttpPost]
        public IActionResult Delete(Borrower borrower)
        {
            context.Borrower.Remove(borrower);
            context.SaveChanges();
            return RedirectToAction("List", "Borrower");
        }
    }
}
