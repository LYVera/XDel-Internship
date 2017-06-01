using System;
using System.Collections;
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
            ViewBag.driverArr = driverArr;
            return View();
        }

        public ActionResult HandleDriverOptions(String check)
        {
            var userOptions = check.Split('|').ToArray();
            LukeRefL2.L2 lukeL2Obj = new LukeRefL2.L2();            
            ArrayList allDriverLatLong = new ArrayList();
            for (int i =0; i<userOptions.Length; i++)
            {
                double[] driverLat = new double[5];
                double[] driverLong = new double[5];
                if (userOptions[i].Contains("#")) //means a driver
                {
                    long driverID = long.Parse(userOptions[i].Substring(1));
                    var driverLoc = lukeL2Obj.GetLocations("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6",driverID,5);
                    for(int j =0; j< driverLoc.Length; j++)
                    {
                        driverLat[j] = driverLoc[j].Latitude; //30 of the driver's location
                        driverLong[j] = driverLoc[j].Longitude; 
                    }
                    ArrayList driverLatLong = new ArrayList();
                    driverLatLong.Add(driverLat); 
                    driverLatLong.Add(driverLong);
                    allDriverLatLong.Add(driverLatLong);
                }
            }
            //ViewBag.AllDriverLoc = allDriverLatLong;
            return Json(allDriverLatLong,JsonRequestBehavior.AllowGet);
            //return PartialView();

        }


        public ActionResult Test(String test)
        {
            return Content("Test Success", "text/plain");
            
        }

    }
}