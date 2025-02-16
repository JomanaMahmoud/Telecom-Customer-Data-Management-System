using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.Pages.Home
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminID"] == null)
            {
                Response.Write("Session is null. Redirecting...");
                Response.Redirect("/Pages/Login/Login.aspx");
            }
            else
            {
                Response.Write("Session exists. AdminID: " + Session["adminID"]);
            }
        }
    }
}