using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication2.Pages.Login
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = ""; // Clear error message on page load
        }

        protected void LoginButton(object sender, EventArgs e)
        {
            string username = txtUsername.Value;
            string password = txtPassword.Value;
           

            if ((username == "58-1034" && password == "1234") || (username == "58-25160" && password=="1234"))
            {
                Response.Redirect("/Pages/Home/Home.aspx");
            }
            else
            {
                lblError.Text = "These are not valid admin credentials. Please try again.";
            }
        }
    }
}
