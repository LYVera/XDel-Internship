using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Device.Location;
using System.Collections;

namespace Try
{
    public partial class Validate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
                long[] arrayOfJobID = lukeObj.GetNewJobsIDX();
                CheckBoxList2.DataSource = arrayOfJobID;
                CheckBoxList2.DataBind();
                getBattery();

            }
            else
            {
                HiddenField2.Value = "";
                HiddenField1.Value = "";
                HiddenField3.Value = "";
            }
        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

        public void getBattery()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = getDriverArray();
            ArrayList lowBatts = new ArrayList();
            for (int i = 0; i < arrayOfDrivers.Length; i++)
            {
                int battPCT = arrayOfDrivers[i].BattPCT;
                if (battPCT < 50)
                {
                    //String toAdd = "";
                    //toAdd = arrayOfDrivers[i].Name + "," + arrayOfDrivers[i].Mobile + "," + arrayOfDrivers[i].BattPCT + "," + arrayOfDrivers[i].BattLastUpdate;
                    lowBatts.Add(arrayOfDrivers[i]);
                }
            }
            Session["lowBatt"] = lowBatts;
        }


        protected void Validate_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();

        }

        public string getSolution(long driverIDX, long[] parameterArray, LukeRef.LukeWS lukeObj)
        {
            lukeObj.ST_CreateTempProblem(driverIDX, 300, 600, parameterArray, null);
            //parameter for temp driver idx
            string tempIDX = "TMP" + driverIDX;
            LukeRef.RouteLocation[] driverJobLocations = lukeObj.ST_GetSol(tempIDX, tempIDX);
            if (driverJobLocations != null)
            {
                for (int k = 0; k < driverJobLocations.Length; k++)
                {
                    long[] arrayOfJobID = driverJobLocations[k].JobsIDXList;
                    LukeRef.Address jobLoc = driverJobLocations[k].Location;
                    string arriveDate = driverJobLocations[k].Arrive.ToShortTimeString();
                    string departDate = driverJobLocations[k].Depart.ToShortTimeString();

                    HiddenField4.Value += jobLoc.postal + "*" + arrayOfJobID[0] + "*" + jobLoc.full_address + "*" + jobLoc.lat + "*" + jobLoc.lon + "*" + arriveDate + "*" + departDate + "*";
                    //driverRoute += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ","; ;
                    //obtain array of delivery jobs id
                    //        long[] dlJobsID = driverJobLocations[k].DLJobsIDXList;
                    //        //if its not a dlvery job 
                    //        if (dlJobsID.Length == 0)
                    //        {
                    //            //obtain array of pick up jobs id
                    //            long[] puJobsID = driverJobLocations[k].PUJobsIDXList;
                    //            HiddenField3.Value += "PU" + "*" + item1.Key.Name +"^";
                    //            //driverRoute += "PU" + "^";
                    //        }
                    //        else
                    //        {
                    //            HiddenField3.Value += "DL" + "*" + item1.Key.Name + "^";
                    //            //driverRoute += "DL" + "^";
                    //        }
                }

                //    HiddenField3.Value += "$";
                //    //driverRoute += "$";
                //return something;
            }
            return null;

        }



        protected void CheckBoxList_Click(object sender, EventArgs e)
        {
            //array for additional pickup jobs (parameter required for create temp job)
            long[] parameterArray = new long[1];
            //create dictionary
            Dictionary<LukeRefL2.DriverObject, double> myDictionary = new Dictionary<LukeRefL2.DriverObject, double>();
            //get array of drivers
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            //declare new array of top 5 drivers
            LukeRefL2.DriverObject[] top5DriverArray = new LukeRefL2.DriverObject[5];
            //populate top 5 driver array with first 5 driver first
            for (int a = 0; a < 5; a++)
            {
                top5DriverArray[a] = driverObjs[a];
            }

            LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
            long[] arrayOfJobID = lukeObj.GetNewJobsIDX();
            //for loop through selected items
            foreach (ListItem item in CheckBoxList2.Items)
                //check if item selected
                if (item.Selected)
                {
                    //for loop through array of job ids from webservice
                    for (int i = 0; i < arrayOfJobID.Length; i++)
                    {
                        //check if selected items == to job id
                        //HiddenField1.Value = item.ToString();
                        //HiddenField2.Value = arrayOfJobID[i].ToString();
                        if (item.ToString().Equals(arrayOfJobID[i].ToString()))
                        {
                            parameterArray[0] = arrayOfJobID[i];
                            //obtain job information
                            LukeRef.JobInfo jobInfo = lukeObj.GetJob("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6", arrayOfJobID[i]);
                            double jobPULat = jobInfo.PULocation.LAT;
                            double jobPULon = jobInfo.PULocation.LNG;
                            //obtain coordinates of new job
                            GeoCoordinate jobCoordinate = new GeoCoordinate(jobPULat, jobPULon);                      
                            //for loop through array for drivers
                            for (int j = 0; j < driverObjs.Length; j++)
                            {
                                LukeRefL2.LocationInfo driverLocation = driverObjs[j].LastKnownLocation;
                                double driverLocationLat = driverLocation.Latitude;
                                double driverLocationLon = driverLocation.Longitude;
                                //obtain coordinates of driver current location
                                GeoCoordinate driverCoordinate = new GeoCoordinate(driverLocationLat, driverLocationLon);
                                //calculate distance from driver location and job location
                                double distanceInKm = jobCoordinate.GetDistanceTo(driverCoordinate) / 1000;
                                //i should populate first 5 drivers, then compare until all achieve top 5 drivers.
                                //after achieving top 5 drivers, validate from first to last
                                myDictionary[driverObjs[j]] = distanceInKm;
                            }
                            //sorted top 5 nearest drivers
                            var top5 = myDictionary.OrderBy(pair => pair.Value).Take(5)
                            .ToDictionary(pair => pair.Key, pair => pair.Value);
                            foreach (var item1 in top5)
                            {
                                
                                long driverIDX = item1.Key.DriverIDX;
                                //call method
                                string solution = getSolution(driverIDX, parameterArray, lukeObj);
                                if(solution != null)
                                {

                                }

                                HiddenField1.Value += item1.Key.LastKnownLocation.Latitude + "*" + item1.Key.LastKnownLocation.Longitude + "*" + item1.Key.Name + "^";
                                HiddenField2.Value += item1.Key.Name + "*" + Math.Round(item1.Value, 2) + "KM" + "^";
                            }
                            HiddenField3.Value += jobPULat + "*" + jobPULon + "*"+ arrayOfJobID[i] + "^";   
                            
                            //get top 5 first then 
                            //lukeObj.ST_CreateTempProblem(driverObjs[i].DriverIDX, 300, 600, )
                            //invoke webservice to run validation


                        }
                    }


                }
        }
    }

}
