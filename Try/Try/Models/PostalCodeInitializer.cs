
using System;
using System.Collections.Generic;
using System.Linq;

namespace Try.Models
{
    public static class PostalCodeInitializer
    {
        private static PolygonO[] polygons;
        private static List<string> colors = new List<string>();
        private static string[] clustering = new string[84];
        private static string[] groupings;

        public static PolygonO[] GetPostalCodes()
        {
            return polygons;
        }
        public static void InitialisePostalCodes()
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

            clustering[1] = "C2";
            clustering[2] = "C2";
            clustering[3] = "C3";
            clustering[4] = "C2";
            clustering[5] = "C1";
            clustering[6] = "C1";
            clustering[7] = "C1";
            clustering[8] = "C1";
            clustering[9] = "W1";
            clustering[10] = "W1";
            clustering[11] = "W1";
            clustering[12] = "W2";
            clustering[13] = "W1";
            clustering[14] = "W1";
            clustering[15] = "W1";
            clustering[16] = "W1";
            clustering[17] = "C3";
            clustering[18] = "C3";
            clustering[19] = "C3";
            clustering[20] = "C3";
            clustering[21] = "C3";
            clustering[22] = "C4";
            clustering[23] = "C4";
            clustering[24] = "C4";
            clustering[25] = "C4";
            clustering[26] = "NW1";
            clustering[27] = "NW1";
            clustering[28] = "NW1";
            clustering[29] = "NW1";
            clustering[30] = "C4";
            clustering[31] = "N1";
            clustering[32] = "N1";
            clustering[33] = "NE1";
            clustering[34] = "NE1";
            clustering[35] = "NE1";
            clustering[36] = "NE1";
            clustering[37] = "NE1";
            clustering[38] = "NE1";
            clustering[39] = "NE1";
            clustering[40] = "NE1";
            clustering[41] = "NE1";
            clustering[42] = "E1";
            clustering[43] = "E1";
            clustering[44] = "E1";
            clustering[45] = "E1";
            clustering[46] = "E1";
            clustering[47] = "E1";
            clustering[48] = "E2";
            clustering[49] = "E2";
            clustering[50] = "E2";
            clustering[51] = "E2";
            clustering[52] = "E2";
            clustering[53] = "NE2";
            clustering[54] = "NE2";
            clustering[55] = "NE2";
            clustering[56] = "N1";
            clustering[57] = "N1";
            clustering[58] = "NW2";
            clustering[59] = "NW2";
            clustering[60] = "W2";
            clustering[61] = "W3";
            clustering[62] = "W3";
            clustering[63] = "W3";
            clustering[64] = "W3";
            clustering[65] = "NW2";
            clustering[66] = "NW2";
            clustering[67] = "NW2";
            clustering[68] = "NW2";
            clustering[69] = "NW2";
            clustering[70] = "NW2";
            clustering[71] = "NW2";
            clustering[72] = "NW2";
            clustering[73] = "N2";
            clustering[74] = "N2";
            clustering[75] = "N2";
            clustering[76] = "N2";
            clustering[77] = "N2";
            clustering[78] = "N2";
            clustering[79] = "NE2";
            clustering[80] = "NE2";
            clustering[81] = "E2";
            clustering[82] = "NE2";

           
        clustering[83] = "N2";

            groupings = new string[] { "C1","C2","C3","C4", "E1", "E2", "N1", "N2", "NE1", "NE2", "NW1", "NW2", "W1","W2","W3","NEW1", "NEW2", "NEW3"};


    string line;
    Int32 count = 0;
    string coordinateStr = "";
    List<PointD> coordinates = new List<PointD> { };
    List<PointD> sortedCoordinates = new List<PointD> { };
    System.IO.StreamReader file = new System.IO.StreamReader("C:\\Users\\Vera\\Downloads\\Telegram Desktop\\Postal Code Boundary Coordinates.csv");
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
                if (!(lat == 0 || lon == 0) && postal< 90)
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
                        polygons[count] = new PolygonO(coordinateStr, CheckColor(count), count, clustering[count]);
count++;
                        coordinateStr = "";
                        coordinateStr = coordinateStr + "[" + lat + "," + lon + "]" + ",";
                    }
                }
            }
            coordinateStr = coordinateStr.Substring(0, coordinateStr.Length - 1);
            polygons[count] = new PolygonO(coordinateStr, CheckColor(count), count, clustering[count]);
file.Close();
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

private static string getPolygonColor(int id)
{
    return polygons[id - 1].Color;
}


private static string CheckColor(int id)
{
    int number = -1;
    string cluster = clustering[id];

    for (int i = 0; i < groupings.Length; i++)
    {
        if (groupings[i] == cluster)
        {
            number = i;
        }
    }
    number++;
    return colors[number];
}


public static void ChangeColor(int i)
{
    if (polygons[i].Color == "#FFFFFF")
    {
        polygons[i].Color = CheckColor(i);
    }
    else
    {
        polygons[i].Color = "#FFFFFF";
    }
}

public static void ChangeClusterColor(int code)
{
    for (int i = 0; i < 84; i++)
    {
        PolygonO poly = polygons[i];
        if (poly.Color == "#FFFFFF")
        {
            poly.Color = colors[code];
            clustering[i] = groupings[code - 1];
        }
    }
}

public static string[] GetClustering()
{
    return clustering;
}
    }
}