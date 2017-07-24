using System;
using System.Collections;
using System.Web;
using Try.Models;

namespace Try
{
    public partial class ManageDrivers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                //load your check box list
                ArrayList driverNameArray = getListOfDriversNames();
                ArrayList clusters = getListOfClusterId();
                driverName.DataSource = driverNameArray;
                driverName.DataBind();
                clusterList.DataSource = clusters;
                clusterList.DataBind();
            }
        }

        public ArrayList getDriverList()
        {
            return PostalCodeInitializer.getAllDrivers();
        }


        public ArrayList getListOfDriversNames()
        {
            ArrayList driversNamesList = new ArrayList();
            ArrayList drivers = getDriverList();
            foreach(Driver driver in drivers)
            {
                driversNamesList.Add(driver.getName());
            }
            return driversNamesList;
        }

        public ArrayList getListOfClusterId()
        {
            ArrayList clusterList = new ArrayList();
            ArrayList clusters = PostalCodeInitializer.getClusters();
            foreach (Cluster cluster in clusters)
            {
                clusterList.Add(cluster.id);
            }
            return clusterList;
        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();
            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;
        }

        protected void driverName_Click(object sender, EventArgs e)
        {
            String name = driverName.SelectedValue;
            String cluster = clusterList.SelectedValue;
            PostalCodeInitializer.changeDriverCluster(name, cluster);
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

        public void logout(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            Response.Redirect("http://localhost:62482/Login");
        }

        public ArrayList retrieveClusters()
        {
            return PostalCodeInitializer.getClusters();
        }
    }
}