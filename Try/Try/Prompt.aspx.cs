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
                //load your check box list                
                LukeRefL2.DriverObject[] driverObjs = getDriverArray();
                String[] driverNameArray = new String[getDriverArray().Length];
                for (int i = 0; i < getDriverArray().Length; i++)
                {
                    driverNameArray[i] = driverObjs[i].Name;
                }

                CheckBoxList1.DataSource = driverNameArray;
                CheckBoxList1.DataBind();
                getBattery();
            }
        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

        protected void CheckBoxList_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();
           
        }

        public void getBattery()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = getDriverArray();
            ArrayList lowBatts = new ArrayList();
            for (int i =0; i< arrayOfDrivers.Length; i++)
            {
                int battPCT = arrayOfDrivers[i].BattPCT;
                if(battPCT < 85)
                {
                    //String toAdd = "";
                    //toAdd = arrayOfDrivers[i].Name + "," + arrayOfDrivers[i].Mobile + "," + arrayOfDrivers[i].BattPCT + "," + arrayOfDrivers[i].BattLastUpdate;
                    lowBatts.Add(arrayOfDrivers[i]);
                }
            }
            Session["lowBatt"] = lowBatts;


        }
    }
}