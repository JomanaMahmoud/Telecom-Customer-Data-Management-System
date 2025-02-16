using System;
using System.Web;

namespace WebApplication2.Pages
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                // Clear the session
                Session.Clear();
                Session.Abandon();

                // Optionally, you can add additional cleanup code here

                // Redirect to the login page
                Response.Redirect("/Pages/Login/Login.aspx");
            }
            else
            {
                // If the request is not a POST, redirect to the login page directly
                Response.Redirect("/Pages/Login/Login.aspx");
            }
        }
    }
}
