﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Try
{
    public partial class Validate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

      
        protected void Validate_Click(object sender, EventArgs e)
        {
            LukeRefL2.DriverObject[] driverObjs = getDriverArray();
            List<ListItem> selected = new List<ListItem>();

        }

    }

}
