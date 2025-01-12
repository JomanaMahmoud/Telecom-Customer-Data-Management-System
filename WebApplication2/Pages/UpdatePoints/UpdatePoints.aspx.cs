using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data; // For Color

namespace WebApplication2.Pages.UpdatePoints
{
    public partial class UpdatePoints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void LoadData(string mobileNum)
        {
            if (string.IsNullOrEmpty(mobileNum))
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

                    // Check if mobile number exists
                    using (SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM customer_account WHERE mobileNo = @mobileNum", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@mobileNum", mobileNum);
                        object result = checkCmd.ExecuteScalar();
                        if (result == null)
                        {
                            ErrorMessageLabel.Text = "Mobile number not found.";
                            return;
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("Total_Points_Account", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@mobile_num", mobileNum);
                        cmd.ExecuteNonQuery();

                        SuccessMessageLabel.Text = "Points updated successfully.";
                        ErrorMessageLabel.Text = ""; // Clear any previous error messages
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                    ErrorMessageLabel.Text = "An error occurred: " + ex.Message;
                }
                finally
                {
                    conn.Close();
                }
            }
        }


        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            ErrorMessageLabel.Text = "";
            SuccessMessageLabel.Text = "";


            string mobileNumber = TextBoxMobileNumber.Text;
            LoadData(mobileNumber);
        }
    }
}