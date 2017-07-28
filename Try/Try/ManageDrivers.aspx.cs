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
                ArrayList usersList = getListOfUsers();
                driverName.DataSource = driverNameArray;
                driverName.DataBind();
                userList.DataSource = usersList;
                userList.DataBind();
            }
        }

        public ArrayList getDriverList()
        {
            return PostalCodeInitializer.getAllDrivers();
        }


        public ArrayList getListOfDriversNames()
        {
            User user = (User)HttpContext.Current.Session["user"];

            ArrayList driversNamesList = new ArrayList();
            ArrayList drivers = getDriverList();
            foreach(Driver driver in drivers)
            {
                if(user != null && (user.getUsername().Equals("admin") || driver.getCoordinator().Equals(user.getUsername())))
                {
                    driversNamesList.Add(driver.getName());
                }
                
            }
            return driversNamesList;
        }

        public ArrayList getListOfUsers()
        {
            ArrayList usersList = new ArrayList();
            ArrayList users = PostalCodeInitializer.retrieveAllUsers();
            foreach (User user in users)
            {
                usersList.Add(user.getUsername());
            }
            return usersList;
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
            String cluster = userList.SelectedValue;
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
            Response.Redirect("Login");
        }
        
    }
}