using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace WebApplication1
{
    public partial class ListSMSOffers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // You can handle any additional logic on page load if needed
        }

        protected void ButtonFetchOffers_Click(object sender, EventArgs e)
        {
            string mobileNo = TextBoxMobileNo.Text.Trim();

            if (string.IsNullOrEmpty(mobileNo))
            {
                LabelStatus.Text = "Please enter a mobile number.";
                return;
            }

            // Fetch SMS offers from database
            string connectionString = ConfigurationManager.ConnectionStrings["Milestone2DB_24"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    // Call the Account_SMS_Offers function
                    string query = "SELECT * FROM dbo.Account_SMS_Offers(@MobileNo)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@MobileNo", mobileNo);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();

                    connection.Open();
                    adapter.Fill(dt);

                    // Check if any records are found
                    if (dt.Rows.Count > 0)
                    {
                        GridViewOffers.DataSource = dt;
                        GridViewOffers.DataBind();
                        GridViewOffers.Visible = true; // Show the GridView if offers are found
                    }
                    else
                    {
                        LabelStatus.Text = "No SMS offers found for this mobile number.";
                        GridViewOffers.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    LabelStatus.Text = $"Error: {ex.Message}";
                    GridViewOffers.Visible = false;
                }
            }
        }
    }
}
