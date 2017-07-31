using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Try
{
    public partial class Prompt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getBattery();
                getDelays();
            }
        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();
            Models.GlobalVariable apiKey = new Models.GlobalVariable();
            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers(apiKey.getKey());
            return arrayOfDrivers;

        }


        // Method to get all the low battery that is < 50%
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


        //Method to get the Red Green and Amber Delays
        public void getDelays()
        {
            // initializing 
            Models.GlobalVariable apiKey = new Models.GlobalVariable();
            LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<long> jobIds = new List<long>();
            List<DateTime> arrivalTime = new List<DateTime>();
            ArrayList PUORDL = new ArrayList();
            DateTime endtime;


            // get each driver to compare their jobs arrival time to end time
            for (int i = 0; i < driverObjs.Length; i++)
            {
                //Get All Jobs of the driver
                LukeRef.RouteLocation[] driverJobs = lukeObj.ST_GetSol(driverObjs[i].DriverIDX.ToString(), driverObjs[i].DriverIDX.ToString());

                // Run through Each Driver Job to get their Job Id and arrival time
                if (driverJobs != null)
                {

                    for (int j = 0; j < driverJobs.Length; j++)
                    {
                        if (driverJobs[j].DLJobsIDXList.Length == 0)
                        {
                            PUORDL.Add("PU");
                        }
                        else
                        {
                            PUORDL.Add("DL");
                        }
                        jobIds.Add(driverJobs[j].JobsIDXList[0]);
                        arrivalTime.Add(driverJobs[j].Arrive);
                    }


                    //Run through each JOBID to getJob and get the timewindow
                    for (int k = 0; k < jobIds.Count; k++)
                    {
                        //Get Job

                        LukeRef.JobInfo jobInfo = lukeObj.GetJob(apiKey.getKey(), jobIds[k]);

                        //If is PickUp
                        if (PUORDL[k].ToString() == "PU")
                        {
                            endtime = jobInfo.PickByDateTime;

                            if (endtime.CompareTo(arrivalTime[k]) < 1)
                            {
                                Delays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + driverObjs[i].ID + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "PU";

                                //Split into red amber green delays
                                if (-1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes > 45 || -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours > 1)
                                {
                                    RedDelays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + jobInfo.PULocation.POSTALCODE + "," + jobInfo.PULocation.STREET + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "PU";
                                    //end of one job
                                    RedDelays.Value += "^";
                                    RedDelaysLatLong.Value += jobInfo.PULocation.LAT + "*" + jobInfo.PULocation.LNG + "*" + jobInfo.PULocation.POSTALCODE + "," + jobInfo.PULocation.STREET + "*PU*" + jobIds[k] + "*" + driverObjs[i].Name + "^";


                                }
                                else if (-1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes > 15 && -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes < 45)
                                {
                                    AmberDelays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + jobInfo.PULocation.POSTALCODE + "," + jobInfo.PULocation.STREET + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "PU";
                                    AmberDelays.Value += "^";

                                    AmberDelaysLatLong.Value += jobInfo.PULocation.LAT + "*" + jobInfo.PULocation.LNG + "*" + jobInfo.PULocation.POSTALCODE + "," + jobInfo.PULocation.STREET + "*PU*" + jobIds[k] + "*" + driverObjs[i].Name + "^";

                                }
                                else if (-1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes < 15 && -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes > 1)
                                {
                                    GreenDelays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + jobInfo.PULocation.POSTALCODE + "," + jobInfo.PULocation.STREET + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "PU";
                                    GreenDelays.Value += "^";

                                    GreenDelaysLatLong.Value += jobInfo.PULocation.LAT + "*" + jobInfo.PULocation.LNG + "*" + jobInfo.PULocation.POSTALCODE + "," + jobInfo.PULocation.STREET + "*PU*" + jobIds[k] + "*" + driverObjs[i].Name + "^";
                                }

                            }

                        }
                        else
                        {
                            endtime = jobInfo.ToDateTime;

                            if (endtime.CompareTo(arrivalTime[k]) < 1)
                            {
                                Delays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + driverObjs[i].ID + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "DL";

                                //Split into red amber green delays
                                if (-1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes > 45 || -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours > 1)
                                {
                                    RedDelays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + jobInfo.DLLocation.POSTALCODE + "," + jobInfo.DLLocation.STREET + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "DL";
                                    //end of one job
                                    RedDelays.Value += "^";

                                    RedDelaysLatLong.Value += jobInfo.DLLocation.LAT + "*" + jobInfo.DLLocation.LNG + "*" + jobInfo.DLLocation.POSTALCODE + "," + jobInfo.DLLocation.STREET + "*DL*" + jobIds[k] + "*" + driverObjs[i].Name + "^";

                                }
                                else if (-1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes > 15 && -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes < 45)
                                {
                                    AmberDelays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + jobInfo.DLLocation.POSTALCODE + "," + jobInfo.DLLocation.STREET + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "DL";
                                    AmberDelays.Value += "^";

                                    AmberDelaysLatLong.Value += jobInfo.DLLocation.LAT + "*" + jobInfo.DLLocation.LNG + "*" + jobInfo.DLLocation.POSTALCODE + "," + jobInfo.DLLocation.STREET + "*DL*" + jobIds[k] + "*" + driverObjs[i].Name + "^";

                                }
                                else if (-1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes < 15 && -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes > 1)
                                {
                                    GreenDelays.Value += jobIds[k] + "*" + driverObjs[i].Name + "*" + jobInfo.DLLocation.POSTALCODE + "," + jobInfo.DLLocation.STREET + "*" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Hours + ":" + -1 * endtime.TimeOfDay.Subtract(arrivalTime[k].TimeOfDay).Minutes + "*" + arrivalTime[k].ToShortDateString() + " / " + arrivalTime[k].TimeOfDay + "*" + endtime.ToShortDateString() + " / " + endtime.TimeOfDay + "*" + "DL";
                                    GreenDelays.Value += "^";
                                    GreenDelaysLatLong.Value += jobInfo.DLLocation.LAT + "*" + jobInfo.DLLocation.LNG + "*" + jobInfo.DLLocation.POSTALCODE + "," + jobInfo.DLLocation.STREET + "*DL*" + jobIds[k] + "*" + driverObjs[i].Name + "^";
                                }

                            }
                        }

                        Delays.Value += "^";
                    }


                }

                //end of driver
                //RedDelays.Value += "%";
                //AmberDelays.Value += "%";
                //GreenDelays.Value += "%";

                //clear the list for next driver
                jobIds.Clear();
                arrivalTime.Clear();
                PUORDL.Clear();

            }
        }
        public void logout(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            Response.Redirect("Login");
        }
    }
}