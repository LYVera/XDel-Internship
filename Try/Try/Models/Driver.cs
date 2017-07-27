using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Try.Models
{
    public class Driver
    {
        private String name { get; set; }
        private String coordinator { get; set; }

        public Driver(String n, String c)
        {
            name = n;
            coordinator = c;
        }

        public string getName()
        {
            return name;
        }
        
        public string getCoordinator()
        {
            return coordinator;
        }

        public void setCoordinator(string c)
        {
            coordinator = c;
        }
    }
}