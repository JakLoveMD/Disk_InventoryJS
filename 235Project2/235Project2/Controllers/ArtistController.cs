﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using _235Project2.Models;

namespace _235Project2.Controllers
{
    public class ArtistController : Controller
    {
        private disk_invjsContext context { get; set; }
        public ArtistController(disk_invjsContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Artist> artists = context.Artist.OrderBy(a => a.ArtistName).Include(t => t.ArtistType).ToList();
            return View(artists);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.Description).ToList();
            return View("Edit", new Artist());
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.Description).ToList();
            var artist = context.Artist.Find(id);
            return View(artist);
        }

        [HttpPost]
        public IActionResult Edit(Artist artist)
        {
            if (ModelState.IsValid)
            {
                if (artist.ArtistId == 0)
                    context.Artist.Add(artist);
                else
                    context.Artist.Update(artist);
                context.SaveChanges();
                return RedirectToAction("List", "Artist");
            }
            else
            {
                ViewBag.Action = (artist.ArtistId == 0) ? "Add" : "Edit";
                ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.Description).ToList();
                return View(artist);
            }
        }

        [HttpGet]
        public IActionResult Delete(int id)
        {
            var artist = context.Artist.Find(id);
            return View(artist);
        }

        [HttpPost]
        public IActionResult Delete(Artist artist)
        {
            context.Artist.Remove(artist);
            context.SaveChanges();
            return RedirectToAction("List", "Artist");
        }
    }
}
