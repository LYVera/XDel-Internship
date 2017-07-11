using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Try.Models
{
    public class PolygonODAO
    {
        private ArrayList polygons;

        public PolygonODAO()
        {
            polygons = new ArrayList();
        }

        public void addPolygon(int postalcode, double lat, double lng)
        {
            Boolean check = true;
            foreach(PolygonO polygon in polygons)
            {
                if(polygon.id == postalcode)
                {
                    polygon.addCoordinates(lat, lng);
                    check = false;
                    break;
                }
            }
            if (check)
            {
                PolygonO polygon = new PolygonO(postalcode);
                polygon.addCoordinates(lat, lng);
                polygons.Add(polygon);
            }
        }

        public ArrayList getPolygons()
        {
            return polygons;
        }

        public PolygonO getPolygonById(int id)
        {
            foreach(PolygonO polygon in polygons)
            {
                if (polygon.id == id)
                {
                    return polygon;
                }
            }
            return null;
        }

        public double getLatCenterOfPolygon(int id)
        {
            int count = 0;
            double totallat = 0.0;
            PolygonO polygon = getPolygonById(id);
            if(polygon != null)
            {
                ArrayList lat = polygon.getLat();
                
                for(int i=0; i<lat.Count; i++)
                {
                    count++;
                    totallat += (double)lat[i];
                    
                }
            }
            return totallat / count;
        }

        public double getLngCenterOfPolygon(int id)
        {
            int count = 0;
            double totallng = 0.0;
            PolygonO polygon = getPolygonById(id);
            if (polygon != null)
            {
                ArrayList lat = polygon.getLat();
                ArrayList lng = polygon.getLng();

                for (int i = 0; i < lat.Count; i++)
                {
                    count++;
                    totallng += (double)lng[i];
                }
                
            }
            return totallng / count ;
        }
    }
}