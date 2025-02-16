using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.Pages.AverageTransactions
{
    public partial class AverageTransactions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminID"] == null)
            {
                // Redirect to the login page if not authenticated
                Response.Redirect("/Pages/Login/Login.aspx");
            }
        }

        private void LoadData(string walletId, string startDate, string endDate)
        {
            if (string.IsNullOrEmpty(walletId))
            {
                ErrorMessageLabel.Text = "Wallet ID is required.";
                return;
            }
            if (string.IsNullOrEmpty(startDate))
            {
                ErrorMessageLabel.Text = "Start Date is required.";
                return;
            }
            if (string.IsNullOrEmpty(endDate))
            {
                ErrorMessageLabel.Text = "End Date is required.";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Check if wallet exists (keep this check)
                    using (SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Wallet WHERE walletID = @walletID", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@walletID", walletId);
                        object result = checkCmd.ExecuteScalar();
                        if (result == null)
                        {
                            ErrorMessageLabel.Text = "Wallet not found.";
                            return;
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("Wallet_Transfer_Amount", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure; // Or CommandType.Text if it's a function, and modify command text
                        cmd.Parameters.AddWithValue("@walletID", walletId);
                        cmd.Parameters.AddWithValue("@start_date", DateTime.Parse(startDate));
                        cmd.Parameters.AddWithValue("@end_date", DateTime.Parse(endDate));

                        SqlParameter returnValue = new SqlParameter();
                        returnValue.Direction = ParameterDirection.ReturnValue;
                        cmd.Parameters.Add(returnValue);

                        cmd.ExecuteNonQuery();

                        int? avgAmount = returnValue.Value as int?;

                        if (avgAmount.HasValue)
                        {
                            AverageAmountLabel.Text = "Average Amount: " + avgAmount.Value.ToString();
                        }
                        else
                        {
                            AverageAmountLabel.Text = "No transactions found."; // Or handle null as needed
                        }
                    }

                }


                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                    ErrorMessageLabel.Text = "An error occurred: " + ex.Message; // Display a generic error message to the user
                }
                finally
                {
                    conn.Close(); // Ensure connection is closed in the finally block
                }
            }
        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            ErrorMessageLabel.Text = "";
            AverageAmountLabel.Text = "";

            string walletId = TextBoxWalletID.Text;
            string startDate = TextBoxStartDate.Text;
            string endDate = TextBoxEndDate.Text;

            LoadData(walletId, startDate, endDate);
        }
    }
}