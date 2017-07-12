using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Device.Location;

namespace Try
{
    public partial class Validate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

      
        protected void Validate_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();

        }

        public void getNewJobs()
        {
            LukeRefL2.DriverObject[] top5DriverArray = new LukeRefL2.DriverObject[5];


            LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
            long[] arrayOfJobID = lukeObj.GetNewJobsIDX();
            for (int i = 0; i < arrayOfJobID.Length; i++)
            {
                LukeRef.JobInfo jobInfo = lukeObj.GetJob("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6", arrayOfJobID[i]);
                double jobPULat = jobInfo.PULocation.LAT;
                double jobPULon = jobInfo.PULocation.LNG;
                GeoCoordinate jobCoordinate = new GeoCoordinate(jobPULat, jobPULon);
                //get array of drivers
                LukeRefL2.DriverObject[] driverObjs = getDriverArray();
                for (int j = 0; j < driverObjs.Length; j++)
                {
                    LukeRefL2.LocationInfo driverLocation = driverObjs[i].LastKnownLocation;
                    double driverLocationLat = driverLocation.Latitude;
                    double driverLocationLon = driverLocation.Longitude;
                    GeoCoordinate driverCoordinate = new GeoCoordinate(driverLocationLat, driverLocationLon);
                    double distanceInKm = jobCoordinate.GetDistanceTo(driverCoordinate) / 1000;


                }


            }
        }


    }

}
