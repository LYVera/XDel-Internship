using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Try.Models
{
    public class Driver
    {
        private String name { get; set; }
        private String cluster { get; set; }

        public Driver(String n, String c)
        {
            name = n;
            cluster = c;
        }

        public string getName()
        {
            return name;
        }

        public string getCluster()
        {
            return cluster;
        }

        public void setCluster(string c)
        {
            cluster = c;
        }
    }
}