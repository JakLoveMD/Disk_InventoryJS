using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using _235Project2.Models;

namespace _235Project2.Controllers
{
    public class HomeController : Controller
    {

        public IActionResult Index()                        //Home page for DiskInventory
        {
            return View();
        }

    }
}
