using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Milestone_3
{
    public partial class CustomerComponent : System.Web.UI.Page
    {   
        string MobileNo = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
                // Example input values, replace with actual inputs from user or session
                MobileNo = Session["accountmn"] as String;
                //int NationalID = 2; // Example NationalID
                //string PlanName = "Premium Plan"; // Example PlanName

                //// ShowConsoleMessage("Retrieving all active benefits...");
                 ShowAllServicePlans(connStr);
                 ShowAllBenefits(connStr);
                 ShowAllShops(connStr);
                 ShowCompanyOfferedPlans(connStr, MobileNo);
                 ShowUsagePlanCM(connStr, MobileNo);
                 ShowSubscribedPlansFiveMonths(connStr, MobileNo);
                 //ShowConsoleMessage("Retrieving unresolved technical support tickets...");
                 //ShowUnresolvedTickets(connStr, NationalID);

                 //ShowConsoleMessage("Retrieving the highest voucher...");
                 //ShowHighestVoucher(connStr, MobileNo);

                 //ShowConsoleMessage("Retrieving remaining amount for the last payment...");
                 //ShowRemainingAmount(connStr, MobileNo, PlanName);

                 //ShowConsoleMessage("Retrieving extra amount for the last payment...");
                 //ShowExtraAmount(connStr, MobileNo, PlanName);

                 //ShowConsoleMessage("Retrieving top 10 successful payments...");
                 ShowTopPayments(connStr, MobileNo);
                 //ShowCashbackWalletCustomer(connStr, 1234567);
                 // Clear console when data is loaded
                 //ClearConsole();
            }
        }

        private void ShowConsoleMessage(string message)
        {
            lblConsole.Text = message;
            lblConsole.Visible = true;
        }

        private void ClearConsole()
        {
            lblConsole.Text = "";
            lblConsole.Visible = false;
        }

        protected void RechargeBalance_Click(object sender, EventArgs e)
        {
            try
            {
                string mobileNumber = MobileNo;
                decimal amount = Convert.ToDecimal(txtRechargeAmount.Text);
                string paymentMethod = ddlPaymentMethod.SelectedValue;

                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Execute the stored procedure to recharge the balance
                    SqlCommand rechargeCmd = new SqlCommand("Initiate_balance_payment", conn);
                    rechargeCmd.CommandType = System.Data.CommandType.StoredProcedure;

                    rechargeCmd.Parameters.AddWithValue("@mobile_num", mobileNumber);
                    rechargeCmd.Parameters.AddWithValue("@amount", amount);
                    rechargeCmd.Parameters.AddWithValue("@payment_method", paymentMethod);

                    conn.Open();
                    rechargeCmd.ExecuteNonQuery();

                    // Query the customer_account table to fetch the current balance
                    SqlCommand balanceCmd = new SqlCommand("SELECT balance FROM customer_account WHERE mobileNo = @mobile_num", conn);
                    balanceCmd.Parameters.AddWithValue("@mobile_num", mobileNumber);

                    object result = balanceCmd.ExecuteScalar();
                    if (result != null)
                    {
                        decimal currentBalance = Convert.ToDecimal(result);
                        ShowPopup($"Balance recharged successfully. Current Balance = {currentBalance:C}");
                    }
                    else
                    {
                        ShowPopup("Balance recharged successfully, but failed to retrieve current balance.");
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowPopup($"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                ShowPopup($"Unexpected error: {ex.Message}");
            }
        }

        // Redeem Voucher
        protected void RedeemVoucher_Click(object sender, EventArgs e)
        {
            try
            {
                int voucherId = Convert.ToInt32(txtVoucherID.Text.Trim()); // Voucher ID input

                if (string.IsNullOrEmpty(MobileNo) || voucherId <= 0)
                {
                    ShowPopup("Please enter a valid mobile number and voucher ID.");
                    return;
                }

                string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Validate if the voucher exists and is valid
                    string validateQuery = @"
            SELECT COUNT(*)
            FROM Voucher
            WHERE voucherID = @voucherId AND mobileNo = @mobileNum AND redeem_date IS NULL";

                    SqlCommand validateCmd = new SqlCommand(validateQuery, conn);
                    validateCmd.Parameters.AddWithValue("@voucherId", voucherId);
                    validateCmd.Parameters.AddWithValue("@mobileNum", MobileNo);

                    int count = (int)validateCmd.ExecuteScalar();

                    if (count == 0)
                    {
                        ShowPopup("Invalid voucher ID or the voucher has already been redeemed.");
                        return;
                    }

                    // Call the stored procedure if validation passes
                    SqlCommand cmd = new SqlCommand("Redeem_voucher_points", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@mobile_num", MobileNo);
                    cmd.Parameters.AddWithValue("@voucher_id", voucherId);

                    cmd.ExecuteNonQuery();
                    ShowPopup("Voucher redeemed successfully.");
                }
            }
            catch (SqlException ex)
            {
                // Handle SQL exceptions
                ShowPopup($"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                // Handle unexpected errors
                ShowPopup($"Unexpected error: {ex.Message}");
            }
        }
        protected void RenewSubscription_Click(object sender, EventArgs e)
        {
            try
            {
                string mobileNumber = MobileNo;
                int planID = Convert.ToInt32(txtPlanID.Text);
                decimal amount = Convert.ToDecimal(txtRenewAmount.Text);
                string paymentMethod = ddlRenewPaymentMethod.SelectedValue;

                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("Initiate_plan_payment", conn); // Correct stored procedure
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@mobile_num", mobileNumber);
                    cmd.Parameters.AddWithValue("@plan_id", planID);
                    cmd.Parameters.AddWithValue("@amount", amount);
                    cmd.Parameters.AddWithValue("@payment_method", paymentMethod);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    ShowPopup("Subscription renewed successfully.");
                }
            }
            catch (SqlException ex)
            {
                ShowPopup($"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                ShowPopup($"Unexpected error: {ex.Message}");
            }
        }


        // Get Cashback Amount
        protected void GetCashbackAmount_Click(object sender, EventArgs e)
        {
            try
            {
                // Get inputs from the form
                string mobileNumber = MobileNo;
                int paymentId = Convert.ToInt32(txtPaymentId.Text); // Payment ID
                int benefitId = Convert.ToInt32(txtBenefitId.Text); // Benefit ID

                if (paymentId <= 0 || benefitId <= 0)
                {
                    ShowPopup("Please provide valid input values.");
                    //cashbackForm.Visible = true; // Ensure the form stays visible
                    return;
                }

                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Execute the stored procedure to apply cashback
                    using (SqlCommand cashbackCmd = new SqlCommand("Payment_wallet_cashback", conn))
                    {
                        cashbackCmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cashbackCmd.Parameters.AddWithValue("@mobile_num", mobileNumber);
                        cashbackCmd.Parameters.AddWithValue("@payment_id", paymentId);
                        cashbackCmd.Parameters.AddWithValue("@benefit_id", benefitId);

                        cashbackCmd.ExecuteNonQuery();
                    }

                    // Fetch the updated wallet balance
                    using (SqlCommand balanceCmd = new SqlCommand(@"
                        SELECT w.current_balance 
                        FROM Wallet w
                        INNER JOIN customer_account a ON w.nationalID = a.nationalID
                        WHERE a.mobileNo = @mobile_num", conn))
                    {
                        balanceCmd.Parameters.AddWithValue("@mobile_num", mobileNumber);

                        object balanceResult = balanceCmd.ExecuteScalar();
                        if (balanceResult != null)
                        {
                            decimal updatedBalance = Convert.ToDecimal(balanceResult);

                            // Display the success message with the updated balance
                            ShowPopup($"Cashback applied successfully! Updated balance: {updatedBalance:C}");
                        }
                        else
                        {
                            ShowPopup("Cashback applied successfully, but failed to retrieve updated balance.");
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowPopup($"Database error: {ex.Message}");
                //cashbackForm.Visible = true; // Ensure the form stays visible
            }
            catch (Exception ex)
            {
                ShowPopup($"Unexpected error: {ex.Message}");
                //cashbackForm.Visible = true; // Ensure the form stays visible
            }
        }
        private void ShowPopup(string message)
        {
            string script = $"<script>alert('{message.Replace("'", "\\'")}');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script);
        }
        private void ShowAllServicePlans(string connStr)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM allServicePlans", conn);
                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();
                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Plan ID</th><th>Plan Name</th><th>Price</th>" +
                                       "<th>SMS Offered</th><th>Minutes Offered</th><th>Data Offered</th><th>Description</th></tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["planID"]}</td>" +
                                     $"<td>{rdr["name"]}</td>" +
                                     $"<td>{"$" +rdr["price"]}</td>" +
                                     $"<td>{rdr["SMS_offered"]}</td>" +
                                     $"<td>{rdr["minutes_offered"]}</td>" +
                                     $"<td>{rdr["data_offered"] +" GB"}</td>" +
                                     $"<td>{rdr["description"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblServicePlans.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Plan ID</th><th>Plan Name</th><th>Price</th><th>SMS Offered</th><th>Minutes Offered</th><th>Data Offered</th><th>Description</th></tr></thead><tbody></tbody></table>"
                    ? tableHtml: "<div class='error'>No service plans found.</div>";
                }
                catch (Exception ex)
                {
                    lblServicePlans.Text = $"<div class='error'>Error retrieving service plans: {ex.Message}</div>";
                }
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            try
            {
                string planname = planName.Text;
                string startdate = startDate.Text;
                string enddate = endDate.Text;

                // Ensure that the dates are valid and can be parsed correctly
                DateTime start = DateTime.Parse(startdate);
                DateTime end = DateTime.Parse(enddate);

                string connectionString = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Call the custom function 'Consumption' to get the data
                    string query = @"
                 SELECT SUM(p.data_consumption) AS TotalInternet,
                        SUM(p.minutes_used) AS TotalMinutes,
                        SUM(p.SMS_sent) AS TotalSMS
                 FROM dbo.Consumption(@PlanName, @StartDate, @EndDate) p";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@PlanName", planname);
                        cmd.Parameters.AddWithValue("@StartDate", start);
                        cmd.Parameters.AddWithValue("@EndDate", end);

                        // Execute the query and get the results
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Retrieve the values from the function
                            int totalSMS = reader.IsDBNull(reader.GetOrdinal("TotalSMS")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalSMS"));
                            int totalMinutes = reader.IsDBNull(reader.GetOrdinal("TotalMinutes")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalMinutes"));
                            int totalInternet = reader.IsDBNull(reader.GetOrdinal("TotalInternet")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalInternet"));

                            // Display the results on the webpage
                            //Response.Write("Total SMS: " + totalSMS.ToString());
                            //Response.Write("Total Minutes: " + totalMinutes.ToString());
                            //Response.Write("Total Internet: " + totalInternet.ToString());
                            lblSMS.Text = $"<div class='number-box'>Total SMS: {totalSMS.ToString()}</div>";
                            lblMins.Text = $"<div class='number-box'>Total Minutes: {totalSMS.ToString()}</div>";
                            lblInt.Text = $"<div class='number-box'>Total Internet: {totalSMS.ToString()}</div>";
                        }
                        else
                        {
                            Response.Write("No data found for the specified criteria.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., invalid date format, SQL errors)
                Response.Write("Error: " + ex.Message);

            }
        }
        private void ShowAllBenefits(string connStr)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM allBenefits", conn);
                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();
                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Benefit ID</th><th>Description</th><th>Validity Date</th>" +
                                       "<th>Status</th><th>Mobile Number</th></tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["benefitID"]}</td>" +
                                     $"<td>{rdr["description"]}</td>" +
                                     $"<td>{Convert.ToDateTime(rdr["validity_date"]).ToShortDateString()}</td>" +
                                     $"<td>{rdr["status"]}</td>" +
                                     $"<td>{rdr["mobileNo"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblBenefits.Text = tableHtml;
                }
                catch (Exception ex)
                {
                    lblBenefits.Text = $"<div class='error'>Error retrieving benefits: {ex.Message}</div>";
                }
            }
        }

        private void ShowAllShops(string connStr)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM allShops", conn);
                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();
                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Shop ID</th><th>Name</th><th>Category</th>" +
                                       "</tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["shopID"]}</td>" +
                                     $"<td>{rdr["name"]}</td>" +
                                     $"<td>{rdr["category"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblShops.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Shop ID</th><th>Name</th><th>Category</th></tr></thead><tbody></tbody></table>"
                        ? tableHtml
                        : "<div class='error'>No shop details found.</div>";
                }
                catch (Exception ex)
                {
                    lblShops.Text = $"<div class='error'>Error retrieving shop details.</div>";
                }
            }
        }
        private void ShowSubscribedPlansFiveMonths(string connStr, string MobileNumber)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {

                    SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Subscribed_plans_5_Months(@mobile_num)", conn);
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNumber));
                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();
                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Plan ID</th><th>Name</th><th>Price</th>" +
                                       "<th>SMS Offered</th><th>Minutes Offered</th><th>Data Offered</th><th>Description</th></tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["planID"]}</td>" +
                                     $"<td>{rdr["name"]}</td>" +
                                     $"<td>{"$" + rdr["price"]}</td>" +
                                     $"<td>{rdr["SMS_offered"]}</td>" +
                                     $"<td>{rdr["minutes_offered"]}</td>" +
                                     $"<td>{rdr["data_offered"] + " GB"}</td>" +
                                     $"<td>{rdr["description"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblSubPlanfivemonths.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Plan ID</th><th>Name</th><th>Price</th><th>SMS Offered</th><th>Minutes Offered</th><th>Data Offered</th><th>Description</th></tr></thead><tbody></tbody></table>" ? tableHtml : "<div class='error'>No service plans subscribed to during the past 5 month found.</div>";
                }
                catch (Exception ex)
                {
                    lblSubPlanfivemonths.Text = $"<div class='error'>Error retrieving service plans subscribed to during the past 5 months.</div>";
                }
            }
        }
        private void ShowUnresolvedTickets(string connStr, int NationalID)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Ticket_Account_Customer", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@NID", NationalID));

                    conn.Open();

                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            int unresolvedTickets = rdr.GetInt32(0);
                            lblTickets.Text = $"<div class='number-box'>The Number Of Unresolved Tickets is: {unresolvedTickets}</div>";
                        }
                        else
                        {
                            lblTickets.Text = "<div class='error'>No unresolved tickets found.</div>";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblTickets.Text = $"<div class='error'>Error retrieving tickets: {ex.Message}</div>";
                }
            }
        }

        private void ShowCompanyOfferedPlans(string connStr, string MobileNumber)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Unsubscribed_Plans", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNumber));

                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Plan Name</th><th>Price</th><th>SMS Offered</th><th>Minutes Offered</th><th>Data Offered</th><th>Description</th></tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["name"]}</td>" +
                                     $"<td>{"$"+rdr["price"]}</td>" +
                                     $"<td>{rdr["SMS_offered"]}</td>" +
                                     $"<td>{rdr["minutes_offered"]}</td>" +
                                     $"<td>{rdr["data_offered"] + " GB"}</td>" +
                                   $"<td>{rdr["description"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblCompanyOfferedPlans.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Plan Name</th><th>Price</th><th>SMS Offered</th><th>Minutes Offered</th><th>Data Offered</th><th>Description</th></tr></thead><tbody></tbody></table>"
                        ? tableHtml
                        : "<div class='error'>No unsubscribed plans found.</div>";
                }
                catch (Exception ex)
                {
                    lblCompanyOfferedPlans.Text = $"<div class='error'>Error retrieving unsubscribed plans: {ex.Message}</div>";
                }
            }
        }

        private void ShowUsagePlanCM(string connStr,string MobileNumber)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {

                    SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Usage_Plan_CurrentMonth(@mobile_num)", conn);
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNumber));
                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();
                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Data Consumption</th><th>Minutes Used</th><th>SMS Sent</th>" +
                                       "</tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["data_consumption"] + " GB"}</td>" +
                                     $"<td>{rdr["minutes_used"]}</td>" +
                                     $"<td>{rdr["SMS_sent"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblPlanUsage.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Data Consumption</th><th>Minutes Used</th><th>SMS Sent</th></tr></thead><tbody></tbody></table>" ? tableHtml: "<div class='error'>No plan usage during the current month found.</div>";
                }
                catch (Exception ex)
                {
                    lblPlanUsage.Text = $"<div class='error'>Error retrieving plan usage during the current month: {ex.Message}</div>";
                }
            }
        }
        private void ShowCashbackWalletCustomer(string connStr, int NationalID)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {

                    SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Cashback_Wallet_Customer(@NID)", conn);
                    cmd.Parameters.Add(new SqlParameter("@NID", NationalID));
                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();
                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Cashback ID</th><th>Benefit ID</th><th>Wallet ID</th><th>Amount</th><th>Credit Date</th>" +
                                       "</tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["cashbackID"]}</td>" +
                                     $"<td>{rdr["benefitID"]}</td>" +
                                     $"<td>{rdr["walletID"]}</td>" +
                                     $"<td>{"$" + rdr["amount"]}</td>" +
                                     $"<td>{Convert.ToDateTime(rdr["credit_date"]).ToShortDateString()}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblCashbackStatus.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Cashback ID</th><th>Benefit ID</th><th>Wallet ID</th><th>Amount</th><th>Credit Date</th></tr></thead><tbody></tbody></table>" ? tableHtml : "<div class='error'>No cashback transaction found related to this wallet.</div>";
                    
                }
                catch (Exception ex)
                {
                    lblCashbackStatus.Text = $"<div class='error'>Error retrieving cashback transaction related to this wallet: {ex.Message}</div>";
                }
            }
        }

        private void ShowHighestVoucher(string connStr, string MobileNo)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Account_Highest_Voucher", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNo));

                    conn.Open();
                    int highestVoucher = (int)cmd.ExecuteScalar();
                    lblHighestVoucher.Text = $"<div class='number-box'>The ID Of The Highest Voucher is: {highestVoucher}</div>";
                }
                catch (Exception ex)
                {
                    lblHighestVoucher.Text = $"<div class='error'>Error retrieving voucher data: {ex.Message}</div>";
                }
            }
        }

        private void ShowRemainingAmount(string connStr, string MobileNo, string PlanName)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SELECT dbo.Remaining_plan_amount(@mobile_num, @plan_name)", conn);
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNo));
                    cmd.Parameters.Add(new SqlParameter("@plan_name", PlanName));

                    conn.Open();
                    var result = cmd.ExecuteScalar();

                    if (result != DBNull.Value)
                    {
                        int remainingAmount = Convert.ToInt32(result);
                        lblRemainingAmount.Text = $"<div class='number-box'> {remainingAmount}</div>";
                    }
                    else
                    {
                        lblRemainingAmount.Text = "<div class='error'>No remaining amount found.</div>";
                    }
                }
                catch (Exception ex)
                {
                    lblRemainingAmount.Text = $"<div class='error'>Error retrieving remaining amount: {ex.Message}</div>";
                }
            }
        }

        private void ShowExtraAmount(string connStr, string MobileNo, string PlanName)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SELECT dbo.Extra_plan_amount(@mobile_num, @plan_name)", conn);
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNo));
                    cmd.Parameters.Add(new SqlParameter("@plan_name", PlanName));

                    conn.Open();
                    var result = cmd.ExecuteScalar();

                    if (result != DBNull.Value)
                    {
                        int extraAmount = Convert.ToInt32(result);
                        lblExtraAmount.Text = $"<div class='number-box'> {extraAmount}</div>";
                    }
                    else
                    {
                        lblExtraAmount.Text = "<div class='error'>No extra amount found.</div>";
                    }
                }
                catch (Exception ex)
                {
                    lblExtraAmount.Text = $"<div class='error'>Error retrieving extra amount: {ex.Message}</div>";
                }
            }
        }
        protected void btnSubmit_Tickets(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
            int NationalID = txtNationalID.Text!=""? int.Parse(txtNationalID.Text):-1;
            ShowUnresolvedTickets(connStr, NationalID);
            ClearConsole();
        }
        protected void btnSubmit_Cashback(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
            int NationalID = TextBoxNationalID.Text != "" ? int.Parse(TextBoxNationalID.Text) : -1;
            ShowCashbackWalletCustomer(connStr, NationalID);
            ClearConsole();
        }
        protected void btnSubmit_RemainingExtraAmount(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
            string PlanName = TextBoxNationalID.Text;
            ShowRemainingAmount(connStr, MobileNo, PlanName);
            ShowExtraAmount(connStr, MobileNo, PlanName);
            ClearConsole();
        }
        private void ShowTopPayments(string connStr, string MobileNo)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Top_Successful_Payments", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@mobile_num", MobileNo));

                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    string tableHtml = "<table class='styled-table sortable'><thead><tr>" +
                                       "<th>Payment ID</th><th>Amount</th><th>Date Of Payment</th><th>Payment Method</th><th>Status</th><th>Mobile Number</th></tr></thead><tbody>";

                    while (rdr.Read())
                    {
                        tableHtml += $"<tr>" +
                                     $"<td>{rdr["paymentID"]}</td>" +
                                     $"<td>{"$" + rdr["amount"]}</td>" +
                                     $"<td>{rdr["date_of_payment"]}</td>" +
                                     $"<td>{rdr["payment_method"]}</td>" +
                                     $"<td>{rdr["status"]}</td>" +
                                     $"<td>{rdr["mobileNo"]}</td>" +
                                     $"</tr>";
                    }

                    tableHtml += "</tbody></table>";
                    lblTopPayments.Text = tableHtml != "<table class='styled-table sortable'><thead><tr><th>Payment ID</th><th>Amount</th><th>Date Of Payment</th><th>Payment Method</th><th>Status</th><th>Mobile Number</th></tr></thead><tbody></tbody></table>"
                        ? tableHtml
                        : "<div class='error'>No successful payments found.</div>";
                }
                catch (Exception ex)
                {
                    lblTopPayments.Text = $"<div class='error'>Error retrieving payments: {ex.Message}</div>";
                }
            }
        }
    }
}