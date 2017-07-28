using System;
using System.Collections;
using System.Web;
using System.Web.UI.WebControls;
using Try.Models;

namespace Try
{
    public partial class ManageUser : System.Web.UI.Page
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
                userList.DataSource = getListofUserNames();
                userList.DataBind();
                roleList.DataSource = getListOfRole();
                roleList.DataBind();
                rightsList.DataSource = getListOfRights();
                rightsList.DataBind();

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

        public ArrayList retrieveUserInfo()
        {
            ArrayList result = new ArrayList();
            ArrayList users = PostalCodeInitializer.retrieveAllUsers();
            foreach(User user in users)
            {
                ArrayList individualUser = new ArrayList();
                individualUser.Add(user.getUsername());
                individualUser.Add(user.getRole());
                individualUser.Add(user.getPostalCodeRights());
                result.Add(individualUser);
            }
            return result;
        }

        public ArrayList retrieveClusters()
        {
            return PostalCodeInitializer.getClusters();
        }

        public ArrayList retrieveUsers()
        {
            return PostalCodeInitializer.retrieveAllUsers();
        }

        public void editUser_Click(object sender, EventArgs e)
        {
            String username = userList.SelectedValue;
            String role = roleList.SelectedValue;
            ArrayList rightsSelected = new ArrayList();
            foreach (ListItem item in rightsList.Items)
            {
                if (item.Selected) rightsSelected.Add(item.Value);
            }
            PostalCodeInitializer.updateUser(username,role,rightsSelected);
        }

        public ArrayList getListofUserNames()
        {
            ArrayList userList = new ArrayList();
            User loggedInUser = (User)HttpContext.Current.Session["user"];
            if (loggedInUser != null)
            {
                ArrayList users = retrieveUsers();
                if (loggedInUser.getRole() == "admin" || loggedInUser.getRole() == "superadmin")
                {
                    foreach (User user in users)
                    {
                        if (user.getRole() == "manager")
                        {
                            userList.Add(user.getUsername());
                        }

                        if (user.getRole() == "admin" && loggedInUser.getRole() == "superadmin")
                        {
                            userList.Add(user.getUsername());
                        }
                    }
                }
            }
            return userList;
        }

        public ArrayList getListOfRole()
        {
            ArrayList rolesList = new ArrayList();
            rolesList.Add("--select--");
            User loggedInUser = (User)HttpContext.Current.Session["user"];
            if (loggedInUser != null)
            {
                if (loggedInUser.getRole() == "admin" || loggedInUser.getRole() == "superadmin")
                {
                    rolesList.Add("manager");
                }
                if (loggedInUser.getRole() == "superadmin")
                {
                    rolesList.Add("admin");
                }
            }
            return rolesList;
        }

        public ArrayList getListOfRights()
        {
            User loggedInUser = (User)HttpContext.Current.Session["user"];
            if(loggedInUser != null)
            {
                return loggedInUser.getPostalCodeRights();
            } else
            {
                return new ArrayList();
            }
        }
    }
}