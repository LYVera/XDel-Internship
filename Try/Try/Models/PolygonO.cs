using System.Collections;

namespace Try.Models
{
    public class PolygonO
    {
        public int id { get; set; }
        public ArrayList lat { get; set; }
        public ArrayList lng { get; set; }

        public PolygonO(int postalcode)
        {
            id = postalcode;
            lat = new ArrayList();
            lng = new ArrayList();
        }
        

        public void addCoordinates(double latnum, double lngnum)
        {
            lat.Add(latnum);
            lng.Add(lngnum);
        }

        public string getCoordinates()
        {
            if (lat.Count > 0) {
                string coordinates = "[" + lat[0] + "," + lng[0] + "]";
                for (int i = 1; i < lat.Count; i++)
                {
                    coordinates = coordinates + "," + "[" + lat[i] + "," + lng[i] + "]";
                }
                return coordinates;
            }
            return "";
        }

        public int getId()
        {
            return id;
        }

        public ArrayList getLat()
        {
            return lat;
        }
        public ArrayList getLng()
        {
            return lng;
        }
    }
}