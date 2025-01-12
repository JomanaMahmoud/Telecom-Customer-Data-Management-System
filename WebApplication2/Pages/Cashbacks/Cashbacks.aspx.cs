using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.Pages.Cashbacks
{
    public partial class Cashbacks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        private void LoadData()
        {
            // Get the connection string from Web.config
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

            // SQL query to select data from the CustomerWallet view
            string query = "SELECT * FROM Num_of_cashback";

            // Create and open a connection
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Create a SqlDataAdapter to fetch data
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);

                    // Fill a DataTable with the data from the view
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind the data to the GridView
                    GridViewDetails.DataSource = dt;
                    GridViewDetails.DataBind();

                    conn.Close();
                }
                catch (Exception ex)
                {
                    // Handle exceptions (e.g., display an error message)
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                }
            }
        }
    }
}