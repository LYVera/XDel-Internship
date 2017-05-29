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

        public ActionResult HandleChecks(String check)
        {
            var userOptions = check.Split('|').ToArray();
            LukeRefL2.L2 lukeL2Obj = new LukeRefL2.L2();
            double[] driverLat = new double[200];
            double[] driverLong = new double[200];
            for (int i =0; i<userOptions.Length; i++)
            {
                if (userOptions[i].Contains("#"))
                {
                    long driverID = long.Parse(userOptions[i].Substring(1));
                    var driverLoc = lukeL2Obj.GetLocations("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6",driverID,30);
                    for(int j =0; j< driverLoc.Length; j++)
                    {
                        driverLat[j] = driverLoc[j].Latitude;
                        driverLong[j] = driverLoc[j].Longitude;
                    }
                }
            }
            ViewBag.Lat = driverLat;
            ViewBag.Long = driverLong;
            ViewBag.NumLoc = driverLat.Length;
            return View();
        }
    }
}