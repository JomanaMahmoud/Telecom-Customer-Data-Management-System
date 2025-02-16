using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class CustomersWithPlans : Page
    {
        // Connection string for the database
        string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminID"] == null)
            {
                // Redirect to the login page if not authenticated
                Response.Redirect("/Pages/Login/Login.aspx");
            }

            if (!IsPostBack)
            {
                // Bind the data to the GridView when the page loads
                BindGridView();
            }
        }

        private void BindGridView()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    // Open the connection to the database
                    conn.Open();

                    // Create the command to execute the stored procedure
                    SqlCommand cmd = new SqlCommand("Account_Plan", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Create a data adapter to fill the GridView with data
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind the data to the GridView
                    GridViewCustomersWithPlans.DataSource = dt;
                    GridViewCustomersWithPlans.DataBind();
                }
                catch (Exception ex)
                {
                    // Handle the exception (e.g., log it or display a message)
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
