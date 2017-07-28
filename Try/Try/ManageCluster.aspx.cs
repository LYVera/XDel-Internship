using System;
using System.Collections;
using System.Web;
using Try.Models;

namespace Try
{
    public partial class ManageCluster : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

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
                ArrayList listofClustersId = getListOfClusterId();
                clusterList.DataSource = listofClustersId;
                clusterList.DataBind();
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

        public void logout(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            Response.Redirect("Login");
        }

        public ArrayList retrieveClusters()
        {
            ArrayList clusters = PostalCodeInitializer.getClusters();
            clusters.RemoveAt(clusters.Count - 1);
            return clusters;
        }

        public ArrayList getListOfClusterId()
        {
            ArrayList clusterList = new ArrayList();
            ArrayList clusters = PostalCodeInitializer.getClusters();
            User user = (User)HttpContext.Current.Session["user"];
            if (user != null)
            {
                ArrayList userRights = user.getPostalCodeRights();
                foreach (Cluster cluster in clusters)
                {
                    if (userRights.Contains(cluster.id))
                    {
                        clusterList.Add(cluster.id);
                    }
                }
            }
            return clusterList;
        }

        protected void addPostal(object sender, EventArgs e)
        {
            PostalCodeInitializer.addPostal(int.Parse(postalcode.Text), clusterList.SelectedValue);
            
        }
    }
}