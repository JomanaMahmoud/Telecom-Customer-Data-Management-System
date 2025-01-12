using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class AccountUsagePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize the page if needed
            }
        }

        protected void ButtonShowUsage_Click(object sender, EventArgs e)
        {
            string mobileNo = TextBoxMobileNo.Text.Trim();
            string fromDate = TextBoxFromDate.Text.Trim();

            if (string.IsNullOrEmpty(mobileNo) || string.IsNullOrEmpty(fromDate))
            {
                // Handle invalid input (e.g., show an error message)
                LabelError.Text = "Please provide both Mobile Number and From Date.";
                return;
            }

            BindGrid(mobileNo, fromDate);
        }

        private void BindGrid(string mobileNo, string fromDate)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Milestone2DB_24"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Query the table-valued function
                using (SqlCommand command = new SqlCommand("SELECT * FROM Account_Usage_Plan(@MobileNo, @From_Date)", connection))
                {
                    // Add parameters
                    command.Parameters.AddWithValue("@MobileNo", mobileNo);
                    command.Parameters.AddWithValue("@From_Date", DateTime.Parse(fromDate));

                    // Execute the query and bind the results
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    GridViewAccountUsage.DataSource = dataTable;
                    GridViewAccountUsage.DataBind();
                }
            }
        }
    }
}
