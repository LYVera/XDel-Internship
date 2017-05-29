using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RSVP.Controllers
{
    public class ShowMapController : Controller
    {
        // GET: ShowMap
        public ActionResult ViewMap()
        {

            LukeRefL2.L2 lukeL2Obj = new LukeRefL2.L2();
            Array driverArr = lukeL2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            ViewBag.Size = driverArr.Length;
            ViewBag.Collection = driverArr;
            return View();
        }


    }
}