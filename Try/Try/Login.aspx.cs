using System;
using System.Web;
using Try.Models;

namespace Try
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenError.Value = "";
        }

        protected void Authenticate(object sender, EventArgs e)
        {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.checkUser(Username.Text, Password.Text);
            if (user != null)
            {
                HttpContext.Current.Session["user"] = user;
                PostalCodeInitializer.InitialisePostalCodes();
                Response.Redirect("Show");

            }
            HiddenError.Value = "Please type a correct username/password";
        }
    }
}