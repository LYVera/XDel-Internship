using RSVP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RSVP.Controllers
{
    public class RecommendMapController : Controller
    {
        // GET: RecommendMap
        public ActionResult RecommendView()
        {
            ViewBag.List = GetPostalCodes();
            return View();
        }

        public string[] GetPostalCodes()
        {
            string line;

            Int32 count = 0;
            string[] result = new string[99];
            string coordinateStr = "";
            List<PointD> coordinates = new List<PointD> { };
            List<PointD> sortedCoordinates = new List<PointD> { };
            System.IO.StreamReader file = new System.IO.StreamReader("C:\\Users\\Vera\\Desktop\\XDel-Internship\\Postal Code Boundary Coordinates.csv");
            file.ReadLine();
            Int32 num = 0;
            while ((line = file.ReadLine()) != null)
            {
                num++;
                string[] tokens = line.Split(',');
                if (tokens[0].Equals(""))
                {
                    break;
                }
                Int32 postal = Int32.Parse(tokens[0]);
                double lat = Double.Parse(tokens[1]);
                double lon = Double.Parse(tokens[2]);
                if (!(lat == 0 || lon == 0) && postal < 90)
                {

                    if (postal == count)
                    {
                        coordinateStr = coordinateStr + "[" + lat + "," + lon + "]" + ",";

                    }
                    else
                    {
                        result[count] = coordinateStr;
                        count++;
                        coordinateStr = "";
                        coordinateStr = coordinateStr + "[" + lat + "," + lon + "]" + ",";
                    }
                }
            }
            result[count] = coordinateStr;
            file.Close();

            return result;
        }

        public static List<PointD> ConvexHull(List<PointD> points)
        {
            if (points.Count < 3)
            {
                throw new ArgumentException("At least 3 points reqired", "points");
            }

            List<PointD> hull = new List<PointD>();

            PointD vPointOnHull = points.Where(p => p.X == points.Min(min => min.X)).First();

            PointD vEndpoint;
            do
            {
                hull.Add(vPointOnHull);
                vEndpoint = points[0];

                for (int i = 1; i < points.Count; i++)
                {
                    if ((vPointOnHull == vEndpoint)
                        || (Orientation(vPointOnHull, vEndpoint, points[i]) == -1))
                    {
                        vEndpoint = points[i];
                    }
                }

                vPointOnHull = vEndpoint;

            }
            while (vEndpoint != hull[0]);

            return hull;
        }

        private static int Orientation(PointD p1, PointD p2, PointD p)
        {
            double Orin = (p2.X - p1.X) * (p.Y - p1.Y) - (p.X - p1.X) * (p2.Y - p1.Y);

            if (Orin > 0)
                return -1;
            if (Orin < 0)
                return 1;

            return 0;
        }
    }
}