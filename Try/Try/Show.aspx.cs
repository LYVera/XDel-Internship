using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Try.Models;

namespace Try
{
    public partial class Show : System.Web.UI.Page
    {

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PostalCodeInitializer.InitialisePostalCodes();
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                //load your check box list                
                ArrayList driverNameArray = getDriversByCoordinator();

                CheckBoxList1.DataSource = driverNameArray;
                CheckBoxList1.DataBind();
                //getTrafficConditions();
                HiddenPostalCode.Value = "0";
                getBattery();
                HiddenPostalCode.Value = "0";
                HiddenTrafficLayer.Value = "0";
                hiddenStatus.Value = "false";
                Grouping.DataSource = getListOfClusterId();
                Grouping.DataBind();

            }
            else
            {
                HiddenField3.Value = "";
                HiddenPostalCode.Value = "1";
                HiddenTrafficLayer.Value = "1";

                //toggle traffic condition
                if (chkTraffic.Checked)
                {
                    getTrafficConditions();
                }
                else
                {
                    HiddenField2.Value = "";
                }

                //toggle route
                if (toggleRoute.Checked)
                {
                    Route_Click();
                }
                else
                {
                    HiddenField3.Value = "";
                }
 
            }



        }
        public ArrayList getDriversByCoordinator()
        {
            User coordinator = (User)HttpContext.Current.Session["user"];
            ArrayList allDrivers = PostalCodeInitializer.getAllDrivers();
            ArrayList driversByCoordinator = new ArrayList();
            foreach (Driver driver in allDrivers){
                if (coordinator != null && (coordinator.getUsername().Equals("admin") || driver.getCoordinator().Equals(coordinator.getUsername()))){
                    driversByCoordinator.Add(driver.getName());
                }
            }
            return driversByCoordinator;
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
                HiddenField2.Value += incident.Message + "*" + incident.Lat + "*" + incident.Long + "^";
            }


        }

        public ArrayList retrieveClusters()
        {
            return PostalCodeInitializer.getClusters();
        }

        public ArrayList getListOfClusterId()
        {
            ArrayList clusterList = new ArrayList();
            ArrayList clusters = PostalCodeInitializer.getClusters();
            for (int i= 0; i < clusters.Count - 1; i++)
            {
                Cluster cluster = (Cluster)clusters[i];
                clusterList.Add(cluster.id);
            }
            return clusterList;
        }

        protected void Route_Click()
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

                        long driverID = driverObjs[i].DriverIDX;
                        LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
                        LukeRef.RouteLocation[] driverJobLocations = lukeObj.ST_GetSol(driverID.ToString(), driverID.ToString());
                        if (driverJobLocations != null)
                        {

                            for (int k = 0; k < driverJobLocations.Length; k++)
                            {
                                LukeRef.Address jobLoc = driverJobLocations[k].Location;
                                string arriveDate = driverJobLocations[k].Arrive.ToShortTimeString();
                                string departDate = driverJobLocations[k].Depart.ToShortTimeString();

                                HiddenField3.Value += jobLoc.postal + "*" + jobLoc.id + "*" + jobLoc.full_address + "*" + jobLoc.lat + "*" + jobLoc.lon + "*" + arriveDate + "*" + departDate + "*";
                                //driverRoute += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ","; ;
                                //obtain array of delivery jobs id
                                long[] dlJobsID = driverJobLocations[k].DLJobsIDXList;
                                //if its not a dlvery job 
                                if (dlJobsID.Length == 0)
                                {
                                    //obtain array of pick up jobs id
                                    long[] puJobsID = driverJobLocations[k].PUJobsIDXList;
                                    HiddenField3.Value += "PU" + "*" + selected[j] + "^";
                                    //driverRoute += "PU" + "^";
                                }
                                else
                                {
                                    HiddenField3.Value += "DL" + "*" + selected[j] + "^";
                                    //driverRoute += "DL" + "^";
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

        // cluster
        protected void Cluster_Click()
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

                        long driverID = driverObjs[i].DriverIDX;
                        LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
                        LukeRef.RouteLocation[] driverJobLocations = lukeObj.ST_GetSol(driverID.ToString(), driverID.ToString());
                        if (driverJobLocations != null)
                        {

                            for (int k = 0; k < driverJobLocations.Length; k++)
                            {
                                LukeRef.Address jobLoc = driverJobLocations[k].Location;
                                HiddenField4.Value += jobLoc.postal + "*" + jobLoc.id + "*" + jobLoc.full_address + "*" + jobLoc.lat + "*" + jobLoc.lon + "*";
                                //driverRoute += jobLoc.postal + "," + jobLoc.id + "," + jobLoc.full_address + "," + jobLoc.lat + "," + jobLoc.lon + ","; ;
                                //obtain array of delivery jobs id
                                long[] dlJobsID = driverJobLocations[k].DLJobsIDXList;
                                //if its not a dlvery job 
                                if (dlJobsID.Length == 0)
                                {
                                    //obtain array of pick up jobs id
                                    long[] puJobsID = driverJobLocations[k].PUJobsIDXList;
                                    HiddenField4.Value += "PU" + "^";
                                    //driverRoute += "PU" + "^";
                                }
                                else
                                {
                                    HiddenField4.Value += "DL" + "^";
                                    //driverRoute += "DL" + "^";
                                }
                            }

                            HiddenField4.Value += "$";
                            //driverRoute += "$";
                        }
                        //Session["driverRoute"] = driverRoute;
                    }

                }
            }
        }

        protected bool checkPostalCodeBoundaryStatus()
        {
            return hiddenStatus.Value == "true";
        }


        protected void CheckBoxList_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();
            foreach (ListItem item in CheckBoxList1.Items)
                if (item.Selected) selected.Add(item);
            HiddenField1.Value = "";
            for (int j = 0; j < selected.Count; j++)
            {
                for (int i = 0; i < driverObjs.Length; i++)
                {
                    if (selected[j].ToString().Equals(driverObjs[i].Name))
                    {
                        LukeRefL2.LocationInfo driverLocation = driverObjs[i].LastKnownLocation;

                        HiddenField1.Value += driverObjs[i].Name + "*" + driverLocation.Latitude + "*" + driverLocation.Longitude + "^";

                    }
                }
            }
        }
        protected ArrayList GetPolygons()
        {
            return Models.PostalCodeInitializer.GetPostalCodes();
        }

        protected void Color_Click(object sender, EventArgs e)
        {
            Models.PostalCodeInitializer.changeCluster(Grouping.SelectedValue);
        }

        protected void polygon_Click(object sender, EventArgs e)
        {
            string id = this.HiddenId.Value;
            if (!id.Equals(""))
            {
                Models.PostalCodeInitializer.changePostal(int.Parse(id), "WHITE");
            }
            hiddenStatus.Value = "true";
        }



        protected ArrayList getClusters()
        {
            return Models.PostalCodeInitializer.getClusters();
        }

        protected string getClusterId(int id)
        {
            return Models.PostalCodeInitializer.getClusterId(id);
        }

        protected string getColor(int id)
        {
            return Models.PostalCodeInitializer.getColor(id);
        }

        protected ArrayList getClusterDetails()
        {
            ArrayList result = new ArrayList();
            ArrayList clusters = PostalCodeInitializer.getClusters();
            ArrayList postalJobs = getPostalJobs();
            User user = (User)HttpContext.Current.Session["user"];
            ArrayList userRights = user.getPostalCodeRights();

            for (int i = 0; i < clusters.Count; i++)
            {
                Cluster cluster = (Cluster)clusters[i];
                if (userRights.Contains(cluster.id))
                {
                    ClusterDetails clusterDetail = new ClusterDetails(cluster.id);
                    ArrayList postalcodes = cluster.postals;
                    if (postalcodes.Count > 0)
                    {
                        clusterDetail.setLat(PostalCodeInitializer.getClusterLatCenter(cluster.id));
                        clusterDetail.setLng(PostalCodeInitializer.getClusterLngCenter(cluster.id));

                        for (int j = 0; j < postalcodes.Count; j++)
                        {
                            int postalcode = (int)postalcodes[j];
                            PostalJob postaljob = null;
                            for (int k = 0; k < postalJobs.Count; k++)
                            {
                                PostalJob current = (PostalJob)postalJobs[k];
                                if (current.getDistrict() == postalcode)
                                {
                                    postaljob = (PostalJob)postalJobs[k];
                                    break;
                                }
                            }

                            if (postaljob != null)
                            {
                                clusterDetail.addNewJob(postaljob.getNewJob());
                                clusterDetail.addPuJob(postaljob.getPIP());
                                clusterDetail.addDelJob(postaljob.getDIP());
                            }

                        }
                        result.Add(clusterDetail);
                    }
                }
            }
            return result;
        }

        protected ArrayList getPostalJobs()
        {
            LukeRef.LukeWS lukeObj = new LukeRef.LukeWS();
            LukeRef.DistrictJobs[] arrayOfDistrictJobs = lukeObj.GetDistrictJobs();
            ArrayList clusters = PostalCodeInitializer.getClusters();
            ArrayList postalJobs = new ArrayList();
            User user = (User)HttpContext.Current.Session["user"];
            ArrayList userRights = user.getPostalCodeRights();
            for (int i = 0; i < arrayOfDistrictJobs.Length; i++)
            {
                int district = int.Parse(arrayOfDistrictJobs[i].District);
                string zone = "";
                foreach (Cluster cluster in clusters)
                {
                    if (cluster.getPostalCodes().Contains(district))
                    {
                        zone = cluster.id;
                        break;
                    }
                }
                if (!zone.Equals("") && userRights.Contains(zone))
                {
                    
                    int newjob = arrayOfDistrictJobs[i].NewJobs;
                    int pip = arrayOfDistrictJobs[i].PIPJobs;
                    int dip = arrayOfDistrictJobs[i].DIPJobs;
                    postalJobs.Add(new PostalJob(zone, district, newjob, dip, pip));
                }
            }
            return postalJobs;
        }

        protected void uncheckAll_Click(object sender, EventArgs e)
        {
            CheckBoxList1.ClearSelection();
            HiddenField1.Value = "";
            HiddenField3.Value = "";
            
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

                        HiddenField1.Value += driverObjs[i].Name + "*" + driverLocation.Latitude + "*" + driverLocation.Longitude + "^";

                    }
                }
            }
            if (toggleRoute.Checked)
            {
                Route_Click();
            }
            else
            {
                HiddenField3.Value = "";
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

        public void logout(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            Response.Redirect("http://localhost:62482/Login");
        }

    }
}