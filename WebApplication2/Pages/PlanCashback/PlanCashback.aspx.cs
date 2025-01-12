using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Pages.Wallets;

namespace WebApplication2.Pages.PlanCashback
{
    public partial class PlanCashback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void LoadData(string walletId, string planId)
        {
            if (walletId.Length == 0)
            {
                ErrorMessageLabel.Text = "Wallet ID is required.";
                return;
            }
            if (planId.Length == 0)
            {
                ErrorMessageLabel.Text = "Plan ID is required.";
                return;
            }
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    // Check if plan exists
                    using (SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Service_plan WHERE planID = @planID", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@planID", planId);

                        object result = checkCmd.ExecuteScalar(); // Efficient for existence check

                        if (result == null)
                        {
                            ErrorMessageLabel.Text = "Plan not found.";
                            return;
                        }
                    }
                    // Check if wallet exists
                    using (SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Wallet WHERE walletID = @walletID", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@walletID", walletId);

                        object result = checkCmd.ExecuteScalar(); // Efficient for existence check

                        if (result == null)
                        {
                            ErrorMessageLabel.Text = "Wallet not found.";
                            return;
                        }
                    }
                    // exec function
                    using (SqlCommand cmd = new SqlCommand("Wallet_Cashback_Amount", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@walletID", walletId);
                        cmd.Parameters.AddWithValue("@planID", planId);


                        // Add an output parameter to retrieve the function's return value
                        SqlParameter returnValue = new SqlParameter();
                        returnValue.Direction = ParameterDirection.ReturnValue;
                        cmd.Parameters.Add(returnValue);
                        cmd.ExecuteNonQuery();
                        string cashbackAmount = returnValue.Value.ToString();
                        CashbackAmountLabel.Text = "Cashback Amount: " + (cashbackAmount.Length > 0 ? cashbackAmount : "0");
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
            CashbackAmountLabel.Text = "";

            string walletId = TextBoxWalletID.Text;
            string planId = TextBoxPlanID.Text;
            LoadData(walletId, planId);
        }
    }
}