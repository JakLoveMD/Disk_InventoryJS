using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
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
            List<Artist> artists = context.Artist.OrderBy(a => a.ArtistName).ToList();
            return View(artists);
        }
    }
}
