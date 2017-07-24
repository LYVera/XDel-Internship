using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Try.Models
{
    public static class PostalCodeInitializer
    {
        
        private static PolygonODAO polygonODao = new PolygonODAO();
        private static ClusterDAO clusterDAO = new ClusterDAO();
        private static UserDAO userDAO = new UserDAO();
        private static DriverDAO driverDAO = new DriverDAO();
        private static ArrayList selected = new ArrayList();

        public static void InitialisePostalCodes()
        {
            polygonODao = new PolygonODAO();
            clusterDAO = new ClusterDAO();
            userDAO = new UserDAO();
            driverDAO = new DriverDAO();
            User user = (User)HttpContext.Current.Session["user"];
            if(user != null)
            {
                ReadCoordinates(user);
            }
        }

        public static ArrayList getClusters()
        {
            return clusterDAO.getClusters();
                
        }

        public static ArrayList GetPostalCodes()
        {
            return polygonODao.getPolygons();
        }

        public static void changePostal(int postal, string id)
        {
            clusterDAO.changePostal(postal, id);
        }

        public static void changeCluster(string id)
        {
            clusterDAO.changeCluster(id);
        }
        
        public static string getColor(int id)
        {
            return clusterDAO.getColor(id);
        }

        public static string getClusterId(int id)
        {
            return clusterDAO.getClusterId(id);
        }

        public static void updateUser(String username, String role, ArrayList rights)
        {
            userDAO.updateUser(username, role, rights);
        }

        public static ArrayList retrieveAllUsers()
        {
            return userDAO.retrieveUsers();
        }
        
        public static ArrayList getAllDrivers()
        {
            return driverDAO.getDrivers();
        }

        public static void changeDriverCluster(String driverName, String clusterId)
        {
            driverDAO.editDriver(driverName, clusterId);
        }


        public static double getClusterLatCenter(string clusterid)
        {
            Cluster cluster = clusterDAO.trackCluster(clusterid);
            ArrayList postalcodes = cluster.getPostalCodes();
            double totalLat = 0.0;
            int count = 0;
            for (int i=0; i<postalcodes.Count; i++)
            {
                count++;
                totalLat += polygonODao.getLatCenterOfPolygon((int)postalcodes[i]);
            }
            return totalLat / count;
        }

        public static double getClusterLngCenter(string clusterid)
        {
            Cluster cluster = clusterDAO.trackCluster(clusterid);
            ArrayList postalcodes = cluster.getPostalCodes();
            double totalLng = 0.0;
            int count = 0;
            for (int i = 0; i < postalcodes.Count; i++)
            {
                count++;
                totalLng += polygonODao.getLngCenterOfPolygon((int)postalcodes[i]);
            }
            return totalLng / count;
        }

        public static void ReadCoordinates(User user)
        {
            string line;
            int postal = 0;
            
            System.IO.StreamReader file = new System.IO.StreamReader("C:\\Users\\Kaiyang\\Documents\\SMU\\XDel\\postal codes\\Postal Code Boundary Coordinates.csv");
            file.ReadLine();

            while ((line = file.ReadLine()) != null)
            {
                string[] tokens = line.Split(',');
                if (tokens[0].Equals(""))
                {
                    break;
                }
                postal = Int32.Parse(tokens[0]);
                double lat = Double.Parse(tokens[1]);
                double lon = Double.Parse(tokens[2]);
                Cluster cluster = clusterDAO.trackPostal(postal);
                
                if (!(lat == 0 || lon == 0) && user.haveRights(cluster.id))
                {
                    polygonODao.addPolygon(postal, lat, lon);
                }
            }
            file.Close();
        }

        public static void addPostal(int postal, string zone)
        {
            clusterDAO.changePostal(postal, zone);
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