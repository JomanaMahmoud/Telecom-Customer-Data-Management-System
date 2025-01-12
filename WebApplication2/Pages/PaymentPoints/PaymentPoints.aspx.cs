using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.Pages.PaymentPoints
{
    public partial class PaymentPoints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void LoadData(string mobileNum) // Accept mobile number as parameter
        {
            if (mobileNum.Length == 0)
            {
                ErrorMessageLabel.Text = "Mobile Number is required.";
                return;
            }
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    // Check if mobile number exists in customer_account table
                    using (SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM customer_account WHERE mobileNo = @mobileNum", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@mobileNum", mobileNum);

                        object result = checkCmd.ExecuteScalar(); // Efficient for existence check

                        if (result == null)
                        {
                            ErrorMessageLabel.Text = "Mobile number not found.";
                            return; // Exit if mobile number doesn't exist
                        }
                    }
                    using (SqlCommand cmd = new SqlCommand("Account_Payment_Points", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@mobile_num", mobileNum); // Pass the parameter

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                dt.Columns[0].ColumnName = "Payment Count";  // Give it a valid name.
                                dt.Columns[1].ColumnName = "Total Points";
                            }
                            GridViewDetails.Visible = true;
                            GridViewDetails.DataSource = dt;
                            GridViewDetails.DataBind();
                        }
                    }
                    conn.Close();
                }
                catch (Exception ex)
                {
                    // Handle exceptions (e.g., display an error message)
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                    // Optionally, display a user-friendly error message on the page.
                    ErrorMessageLabel.Text = "An error occurred: " + ex.Message;
                }
            }
        }
        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            ErrorMessageLabel.Text = "";
            GridViewDetails.Visible = false;
            GridViewDetails.DataSource = null;
            GridViewDetails.DataBind();

            string mobileNumber = TextBoxMobileNumber.Text;
            LoadData(mobileNumber);
        }
    }
}