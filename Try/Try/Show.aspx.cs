using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Try
{
    public partial class Show : System.Web.UI.Page
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
                getTrafficConditions();
                getBattery();
                HiddenPostalCode.Value = "0";
                HiddenTrafficLayer.Value = "0";
            }
            else
            {

                //lblmessage.Text = "hi can";
                HiddenField1.Value = "";
                HiddenField3.Value = "";
                HiddenPostalCode.Value = "1";
                HiddenTrafficLayer.Value = "1";
            }



        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

        public void getTrafficConditions()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.LTAIncident[] arrayOfIncidents = luke2Obj.GetLTAIncidents("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");

            foreach (LukeRefL2.LTAIncident incident in arrayOfIncidents)
            {
                HiddenField2.Value += incident.Message + "," + incident.Lat + "," + incident.Long + "@";
            }


        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            String driverRoute = "";
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();
            foreach (ListItem item in CheckBoxList1.Items)
                if (item.Selected) selected.Add(item);

            for (int j = 0; j < selected.Count; j++)
            {
                for (int i = 0; i < driverObjs.Length; i++)
                {
                    if (selected[j].ToString().Equals(driverObjs[i].Name))
                    {
                        if (courRoute.Checked == true)
                        {
                            long driverID = driverObjs[i].DriverIDX;
                            LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
                            LukeRef.RouteLocation[] driverJobLocations = lukeObj.ST_GetSol(driverID.ToString(), driverID.ToString());
                            if (driverJobLocations != null)
                            {

                                for (int k = 0; k < driverJobLocations.Length; k++)
                                {
                                    LukeRef.Address jobLoc = driverJobLocations[k].Location;
                                    HiddenField3.Value += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ",";
                                    //driverRoute += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ","; ;
                                    //obtain array of delivery jobs id
                                    long[] dlJobsID = driverJobLocations[k].DLJobsIDXList;
                                    //if its not a dlvery job 
                                    if (dlJobsID.Length == 0)
                                    {
                                        //obtain array of pick up jobs id
                                        long[] puJobsID = driverJobLocations[k].PUJobsIDXList;
                                        HiddenField3.Value += "PU" + "@";
                                        //driverRoute += "PU" + "@";
                                    }
                                    else
                                    {
                                        HiddenField3.Value += "DL" + "@";
                                        //driverRoute += "DL" + "@";
                                    }
                                }

                                HiddenField3.Value += "$";
                                //driverRoute += "$";
                            }
                            //Session["driverRoute"] = driverRoute;
                        }
                    }
                }
            }
        }


        protected void CheckBoxList_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();
            foreach (ListItem item in CheckBoxList1.Items)
                if (item.Selected) selected.Add(item);

            for (int j = 0; j < selected.Count; j++)
            {
                for (int i = 0; i < driverObjs.Length; i++)
                {
                    if (selected[j].ToString().Equals(driverObjs[i].Name))
                    {
                        LukeRefL2.LocationInfo driverLocation = driverObjs[i].LastKnownLocation;

                        HiddenField1.Value += driverObjs[i].Name + "," + driverLocation.Latitude + "," + driverLocation.Longitude + "@";

                    }
                }
            }
        }

        public Models.PolygonO[] getPolygon()
        {
            Models.PostalCodeInitializer PostalCodeDAO = new Models.PostalCodeInitializer();
            Models.PolygonO[] polygons = PostalCodeDAO.GetPostalCodes();
            return polygons;
        }

        protected void uncheckAll_Click(object sender, EventArgs e)
        {
            for (int items = 0; items < CheckBoxList1.Items.Count; items++)
            {
                CheckBoxList1.ClearSelection();
            }
        }

        protected void selectAll_Click(object sender, EventArgs e)
        {
            foreach (ListItem listItem in CheckBoxList1.Items)
            {
                listItem.Selected = true;
            }

            List<ListItem> selected = new List<ListItem>();
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            foreach (ListItem item in CheckBoxList1.Items)
                if (item.Selected) selected.Add(item);

            for (int j = 0; j < selected.Count; j++)
            {
                for (int i = 0; i < driverObjs.Length; i++)
                {
                    if (selected[j].ToString().Equals(driverObjs[i].Name))
                    {
                        LukeRefL2.LocationInfo driverLocation = driverObjs[i].LastKnownLocation;

                        HiddenField1.Value += driverObjs[i].Name + "," + driverLocation.Latitude + "," + driverLocation.Longitude + "@";

                    }
                }
            }
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

    }
}