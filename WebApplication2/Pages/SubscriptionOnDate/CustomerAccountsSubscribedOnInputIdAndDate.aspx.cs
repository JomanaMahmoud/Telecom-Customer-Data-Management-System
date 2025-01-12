using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.Pages.SubscriptionOnDate
{
    public partial class CustomerAccountsSubscribedOnInputIdAndDate : System.Web.UI.Page
    {
        private string planIdText;
        private string subscriptionDateText;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void FetchButton_Click(object sender, EventArgs e)
        {
            // Retrieve values from the textboxes
            planIdText = txtplanId.Text.Trim(); // Trim any leading/trailing spaces
            subscriptionDateText = txtsubscriptionDate.Text.Trim();

            // Validation checks
            if (string.IsNullOrEmpty(planIdText) || string.IsNullOrEmpty(subscriptionDateText))
            {
                // Handle missing input
                return;
            }

            // Parse the date and planId
            DateTime subscriptionDate;
            if (!DateTime.TryParse(subscriptionDateText, out subscriptionDate))
            {
                // Handle invalid date input
                return;
            }

            int planId = 0;
            if (!int.TryParse(planIdText, out planId))
            {
                // Handle invalid plan ID input
                return;
            }

            // Fetch the data from the database
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
            string query = "SELECT * FROM dbo.Account_Plan_date(@sub_date, @plan_id)";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@sub_date", subscriptionDate);
                cmd.Parameters.AddWithValue("@plan_id", planId);

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                // Bind the data to the GridView
                GridViewAccounts.DataSource = dt;
                GridViewAccounts.DataBind();
            }
        }

    }
}