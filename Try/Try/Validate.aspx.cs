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
                radioList.DataSource = arrayOfJobID;
                radioList.DataBind();
                getBattery();

            }
            else
            {
                HiddenField2.Value = "";
                HiddenField1.Value = "";
                HiddenField3.Value = "";
                HiddenField4.Value = "";
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

        public string getTempSolution(long driverIDX, long[] parameterArray, LukeRef.LukeWS lukeObj)
        {
            string solution = "";
            lukeObj.ST_CreateTempProblem(driverIDX, 300, 600, parameterArray, null);
            //parameter for temp driver idx
            string tempIDX = "TMP" + driverIDX;
            LukeRef.RouteLocation[] driverJobLocations = lukeObj.ST_GetSol(tempIDX, tempIDX);
            if (driverJobLocations != null)
            {
                solution += "(" + driverJobLocations.Length + ")" + "^";
                for (int k = 0; k < driverJobLocations.Length; k++)
                {
                    long[] arrayOfJobID = driverJobLocations[k].JobsIDXList;
                    LukeRef.Address jobLoc = driverJobLocations[k].Location;
                    string arriveDate = driverJobLocations[k].Arrive.ToShortTimeString();
                    string departDate = driverJobLocations[k].Depart.ToShortTimeString();

                    solution += arrayOfJobID[0] + "*" + jobLoc.postal + "*" + jobLoc.full_address + "*" + arriveDate + "*" + departDate + "*";
                    //driverRoute += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ","; ;
                    //obtain array of delivery jobs id
                    long[] dlJobsID = driverJobLocations[k].DLJobsIDXList;
                    //if its not a dlvery job 
                    if (dlJobsID.Length == 0)
                    {
                        //obtain array of pick up jobs id
                        long[] puJobsID = driverJobLocations[k].PUJobsIDXList;

                        solution += "PU" + "^";
                    }
                    else
                    {

                        solution += "DL" + "^";
                    }
                }

                return solution;
            }
            return null;

        }

        public string getSolution(long driverIDX, long[] parameterArray, LukeRef.LukeWS lukeObj)
        {
            string solution = "";
            //get real solution of drivers
            LukeRef.RouteLocation[] driverJobLocations = lukeObj.ST_GetSol(driverIDX.ToString(), driverIDX.ToString());
            if (driverJobLocations != null && driverJobLocations.Length > 0)
            {
                solution += "(" + driverJobLocations.Length + ")" + "^";
                for (int k = 0; k < driverJobLocations.Length; k++)
                {
                    long[] arrayOfJobID = driverJobLocations[k].JobsIDXList;
                    LukeRef.Address jobLoc = driverJobLocations[k].Location;
                    string arriveDate = driverJobLocations[k].Arrive.ToShortTimeString();
                    string departDate = driverJobLocations[k].Depart.ToShortTimeString();

                    solution += arrayOfJobID[0] + "*" + jobLoc.postal + "*" + jobLoc.full_address + "*" + arriveDate + "*" + departDate + "*";
                    //driverRoute += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ","; ;
                    //obtain array of delivery jobs id
                    long[] dlJobsID = driverJobLocations[k].DLJobsIDXList;
                    //if its not a dlvery job 
                    if (dlJobsID.Length == 0)
                    {
                        //obtain array of pick up jobs id
                        long[] puJobsID = driverJobLocations[k].PUJobsIDXList;

                        solution += "PU" + "^";
                    }
                    else
                    {

                        solution += "DL" + "^";
                    }
                }
                return solution;
            }
            return null;

        }



        protected void RadioList_Click(object sender, EventArgs e)
        {
            Driver1.Value = "";
            Driver2.Value = "";
            Driver3.Value = "";
            Driver4.Value = "";
            Driver5.Value = "";
            IDX2.Value = "";
            IDX3.Value = "";
            IDX4.Value = "";
            IDX5.Value = "";
            NewJobsIDX.Value = "";
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
            foreach (ListItem item in radioList.Items)
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
                            //for loop through dictionary of top 5 drivers
                            for (int b = 0; b < top5.Count; b++)
                            {
                                var element = top5.ElementAt(b);
                                if (b == 0)
                                {

                                    //Retrieve element in dictionary top 5
                                    Driver1.Value += element.Key.Name + " " + Math.Round(element.Value, 2) + "KM ";
                                    long driverIDX = element.Key.DriverIDX;
                                    //Ensure temp solution is only calculated for first driver
                                    string tempSolution = getTempSolution(driverIDX, parameterArray, lukeObj);
                                    if (tempSolution == null)
                                    {
                                        Driver1.Value += getSolution(driverIDX, parameterArray, lukeObj);
                                    }
                                    else
                                    {
                                        Driver1.Value += tempSolution;
                                    }
                                    //For driver marker contains coordinates 
                                    HiddenField1.Value += element.Key.LastKnownLocation.Latitude + "*" + element.Key.LastKnownLocation.Longitude + "*" + element.Key.Name + "^";
                                }
                                else if (b == 1)
                                {
                                    Driver2.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    IDX2.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    long driverIDX = element.Key.DriverIDX;
                                    IDX2.Value += getTempSolution(driverIDX, parameterArray, lukeObj);
                                    Driver2.Value += getSolution(driverIDX, parameterArray, lukeObj);
                                    //For driver marker contains coordinates 
                                    HiddenField1.Value += element.Key.LastKnownLocation.Latitude + "*" + element.Key.LastKnownLocation.Longitude + "*" + element.Key.Name + "^";
                                }
                                else if (b == 2)
                                {
                                    Driver3.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    IDX3.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    long driverIDX = element.Key.DriverIDX;
                                    IDX3.Value += getTempSolution(driverIDX, parameterArray, lukeObj);
                                    Driver3.Value += getSolution(driverIDX, parameterArray, lukeObj);
                                    //For driver marker contains coordinates 
                                    HiddenField1.Value += element.Key.LastKnownLocation.Latitude + "*" + element.Key.LastKnownLocation.Longitude + "*" + element.Key.Name + "^";
                                }
                                else if (b == 3)
                                {
                                    Driver4.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    IDX4.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    long driverIDX = element.Key.DriverIDX;
                                    IDX4.Value += getTempSolution(driverIDX, parameterArray, lukeObj);
                                    Driver4.Value += getSolution(driverIDX, parameterArray, lukeObj);
                                    //For driver marker contains coordinates 
                                    HiddenField1.Value += element.Key.LastKnownLocation.Latitude + "*" + element.Key.LastKnownLocation.Longitude + "*" + element.Key.Name + "^";
                                }
                                else
                                {
                                    Driver5.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    IDX5.Value += top5.ElementAt(b).Key.Name + " " + Math.Round(top5.ElementAt(b).Value, 2) + "KM ";
                                    long driverIDX = element.Key.DriverIDX;
                                    IDX5.Value += getTempSolution(driverIDX, parameterArray, lukeObj);
                                    Driver5.Value += getSolution(driverIDX, parameterArray, lukeObj);
                                    //For driver marker contains coordinates 
                                    HiddenField1.Value += element.Key.LastKnownLocation.Latitude + "*" + element.Key.LastKnownLocation.Longitude + "*" + element.Key.Name + "^";
                                }


                            }
                            //For job marker contains coordinates
                            HiddenField3.Value += jobPULat + "*" + jobPULon + "*" + arrayOfJobID[i] + "^";

                            //get top 5 first then 
                            //lukeObj.ST_CreateTempProblem(driverObjs[i].DriverIDX, 300, 600, )
                            //invoke webservice to run validation


                        }
                    }


                }
            NewJobsIDX.Value += parameterArray[0];
        }
        public void logout(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            Response.Redirect("http://localhost:62482/Login");
        }
        public void ValidateSecond(object sender, EventArgs e)
        {
            Driver2.Value = IDX2.Value;
        }
        public void ValidateThird(object sender, EventArgs e)
        {
            Driver3.Value = IDX3.Value;
        }
        public void ValidateFourth(object sender, EventArgs e)
        {
            Driver4.Value = IDX4.Value;
        }
        public void ValidateFifth(object sender, EventArgs e)
        {
            Driver5.Value = IDX5.Value;
        }



    }

}
//bye keane, have fun!!!!! I love u!