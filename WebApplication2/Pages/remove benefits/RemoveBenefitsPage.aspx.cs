using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class RemoveBenefitsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LabelStatus.Text = string.Empty;
            }
        }
        protected void ButtonRemoveBenefits_Click(object sender, EventArgs e)
        {
            string mobileNo = TextBoxMobileNo.Text.Trim();
            string planID = TextBoxPlanID.Text.Trim();

            if (string.IsNullOrEmpty(mobileNo) || string.IsNullOrEmpty(planID))
            {
                LabelStatus.Text = "Please provide both your Mobile Number and Plan ID.";
                return;
            }

            // Call the stored procedure
            string connectionString = ConfigurationManager.ConnectionStrings["Milestone2DB_24"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand("Benefits_Account", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Correct the parameter names to match what the stored procedure expects
                        command.Parameters.AddWithValue("@mobile_num", mobileNo);  // Match parameter name @mobile_num
                        command.Parameters.AddWithValue("@plan_id", int.Parse(planID));  // Match parameter name @plan_id

                        // Open connection and execute the command
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        // Feedback to the user
                        if (rowsAffected > 0)
                        {
                            LabelStatus.Text = "Your benefits have been successfully removed.";
                        }
                        else
                        {
                            LabelStatus.Text = "We could not find any benefits associated with this mobile number and plan. You may not be subscribed to this plan or the benefits have already been removed.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    LabelStatus.Text = $"Something went wrong. Please try again later or contact support. Error: {ex.Message}";
                }
            }
        }



    }
}
