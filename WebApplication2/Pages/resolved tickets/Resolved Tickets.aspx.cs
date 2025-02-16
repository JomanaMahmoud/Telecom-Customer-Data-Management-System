using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Resolved_Tickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminID"] == null)
            {
                // Redirect to the login page if not authenticated
                Response.Redirect("/Pages/Login/Login.aspx");
            }

            string connectionString = ConfigurationManager.ConnectionStrings["Milestone2DB_24"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "select * from allResolvedTickets";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    GridViewResolvedTickets.DataSource = dataTable;
                    GridViewResolvedTickets.DataBind();
                }
            }
        }
    }
}