using System;
using System.Collections.Generic;
using System.Linq;
using Try.Models;

namespace Try.Models
{
    public class PostalCodeInitializer
    {
        private PolygonO[] polygons;
        List<string> colors = new List<string>();

        public PostalCodeInitializer()
        {
            polygons = new PolygonO[99];
            colors.Add("#E55F5F");
            colors.Add("#6b34db");
            colors.Add("#d234db");
            colors.Add("#db3439");
            colors.Add("#db8f34");
            colors.Add("#dbd234");
            colors.Add("#81db34");
            colors.Add("#34db63");
            colors.Add("#34d2db");
            colors.Add("#055b60");
            colors.Add("#053460");
            colors.Add("#340560");
            colors.Add("#600556");
            colors.Add("#60050c");
            colors.Add("#602c05");
            colors.Add("#5c6005");
            colors.Add("#1d6005");
            colors.Add("#05601b");
        }

        public PolygonO[] GetPostalCodes()
        {
            string line;
            Int32 count = 0;
            string coordinateStr = "";
            List<PointD> coordinates = new List<PointD> { };
            List<PointD> sortedCoordinates = new List<PointD> { };
            System.IO.StreamReader file = new System.IO.StreamReader("D:\\Documents\\XDEL\\Postal Code Boundary Coordinates.csv");
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
                        if (coordinateStr.Length > 3)
                        {
                            coordinateStr = coordinateStr.Substring(0, coordinateStr.Length - 1);
                        }
                        polygons[count] = new PolygonO(coordinateStr, CheckColor(count), count);
                        count++;
                        coordinateStr = "";
                        coordinateStr = coordinateStr + "[" + lat + "," + lon + "]" + ",";
                    }
                }
            }
            coordinateStr = coordinateStr.Substring(0, coordinateStr.Length - 1);
            polygons[count] = new PolygonO(coordinateStr, CheckColor(count), count);
            file.Close();

            return polygons;
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

        private string getPolygonColor(int id)
        {
            return polygons[id - 1].Color;
        }

        private string CheckColor(int i)
        {
            return colors[i % colors.Count];
        }
    }
}
