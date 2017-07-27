using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Try.Models
{
    public class PostalJob
    {
        private string zone { get; set; }
        private int district { get; set; }
        private int newjob { get; set; }
        private int dip { get; set; }
        private int pip { get; set; }

        public PostalJob(string z,  int dis, int nj, int d, int p)
        {
            zone = z;
            district = dis;
            newjob = nj;
            dip = d;
            pip = p;
        }

        public string getZone()
        {
            return zone;
        }

        public int getDistrict()
        {
            return district;
        }

        public int getNewJob()
        {
            return newjob;
        }
        public int getDIP()
        {
            return dip;
        }
        public int getPIP()
        {
            return pip;
        }
    }
}