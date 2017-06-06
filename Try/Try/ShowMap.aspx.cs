using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Try
{
    public partial class ShowMap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
           if (!IsPostBack)
            {
               //load your check box list                
                LukeRefL2.DriverObject[] driverObjs = getDriverArray();
                String[] driverNameArray = new String[getDriverArray().Length];
                for (int i =0; i< getDriverArray().Length; i++)
                {
                    driverNameArray[i] = driverObjs[i].Name;
                }

                CheckBoxList1.DataSource = driverNameArray;
                CheckBoxList1.DataBind();
                
            } else
            {

                //lblmessage.Text = "hi can";
                HiddenField1.Value = "";

            }
        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();
            foreach (ListItem item in CheckBoxList1.Items)
                if (item.Selected) selected.Add(item);

            for(int j = 0; j < selected.Count; j++)
            {
                for(int i = 0; i < driverObjs.Length; i++)
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
    }
}
