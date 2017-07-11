using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Try
{
    public partial class DashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                getBattery();


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

        public ArrayList topHighestLowest()
        {

            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();
            
            LukeRefL2.DriverObject[] arrayOfDrivers = getDriverArray();
            ArrayList driverIDx = new ArrayList();
            ArrayList driverPoints = new ArrayList();
            DateTime thisDay = DateTime.Today;

            // to get all driverIDX
            for (int i = 0; i < arrayOfDrivers.Length; i++)
            {
                driverIDx.Add(arrayOfDrivers[i].DriverIDX);
            }

            for (int i = 0; i < arrayOfDrivers.Length; i++)
            {
                String driverPointDetails = "";
                LukeRefL2.DriverPointSummary[] details = luke2Obj.L2_GetDriverPointSummary("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6", arrayOfDrivers[i].DriverIDX, thisDay, thisDay);
                for(int j =0; j < details.Length; j++)
                {
                    driverPointDetails += details[j].Points;
                    
                }

                driverPoints.Add(driverPointDetails);
            }

            return driverPoints;
        }
    }




}