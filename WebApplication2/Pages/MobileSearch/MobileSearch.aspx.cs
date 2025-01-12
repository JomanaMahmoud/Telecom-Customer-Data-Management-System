using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.Pages.MobileSearch
{
    public partial class MobileSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void LoadData(string mobileNumber) // Corrected parameter
        {
            if (string.IsNullOrEmpty(mobileNumber))
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

                    using (SqlCommand cmd = new SqlCommand("Wallet_MobileNo", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@mobile_num", mobileNumber);

                        SqlParameter returnValue = new SqlParameter();
                        returnValue.Direction = ParameterDirection.ReturnValue;
                        cmd.Parameters.Add(returnValue);

                        cmd.ExecuteNonQuery();

                        bool walletExists = (bool)returnValue.Value;

                        if (walletExists)
                        {
                            SearchResultLabel.Text = "Wallet found for this mobile number.";
                            SearchResultLabel.ForeColor = Color.Green; // Set to green if found
                        }
                        else
                        {
                            SearchResultLabel.Text = "No wallet found for this mobile number.";
                            SearchResultLabel.ForeColor = Color.Red;   // Set to red if not found
                        }

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
            SearchResultLabel.Text = "";


            string mobileNumber = TextBoxMobileNumber.Text;
            LoadData(mobileNumber);

        }
    }
}