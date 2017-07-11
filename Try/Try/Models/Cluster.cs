using System;
using System.Collections;

namespace Try.Models
{
    public class Cluster
    {
        public string id { get; set; }
        public string name { get; set; }
        public ArrayList postals { get; set; }
        public string color { get; set; }
        
        public Cluster(string i, string n, ArrayList p, string c)
        {
            id = i;
            name = n;
            postals = p;
            color = c;
        }

        public ArrayList getPostalCodes()
        {
            return postals;
        }

        public void addPostalCode(int postal)
        {
            postals.Add(postal);
            string c = color;
        }

        public void removePostalCode(int postal)
        {
            postals.Remove(postal);
        }

        public Boolean containsPostal(int postal)
        {
            foreach (int postalcode in postals)
            {
                if(postalcode == postal)
                {
                    return true;
                }
            }
            return false;
        }
        
    }
}