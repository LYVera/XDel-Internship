using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Try
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Forget(object sender, EventArgs e)
        {
            //Run thru database to check if user id is correct
            //if not correct, throw an error
            //if correct, Send new password to user's email address
        }
    }
}