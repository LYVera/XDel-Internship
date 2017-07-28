using System;
using System.Web;

namespace Try
{
    public partial class Include : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["user"] == null)
            {
                Response.Redirect("Login");
            }
        }
    }
}