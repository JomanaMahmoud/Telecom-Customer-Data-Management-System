using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void loginm(object sender, EventArgs e)
        {   
            // Database connection
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2DB_24"].ToString();
            SqlConnection sqlConnection = new SqlConnection(connStr);


            if (mnumber == null || password == null)
            {
                Response.Write("<script>alert('Controls not initialized properly. Please check the page structure.');</script>");
                return;
            }

            // Read user inputs
            string accountmn = mnumber.Text.Trim();
            string pass = password.Text.Trim();

            Session["accountmn"]= accountmn;

            // Validate inputs
            if (string.IsNullOrEmpty(accountmn) || string.IsNullOrEmpty(pass))
            {
                Response.Write("<script>alert('Please fill in all fields.');</script>");
                return;
            }

            

            try
            {   // Open connection
                sqlConnection.Open();


                // Define the SQL command to call the validation function
                SqlCommand loginpfunc = new SqlCommand("SELECT dbo.AccountLoginValidation(@mobile_num, @pass)", sqlConnection);
                loginpfunc.CommandType = System.Data.CommandType.Text;

                // Add parameters
                loginpfunc.Parameters.AddWithValue("@mobile_num", accountmn);
                loginpfunc.Parameters.AddWithValue("@pass", pass);

                

                // Execute the query
                object resultObj = loginpfunc.ExecuteScalar();
                int result = resultObj != null ? Convert.ToInt32(resultObj) : 0;

                // Check result
                if (result == 1)
                {
                    // Login successful
                    Session["accountmn"] = accountmn; // Save session data
                    Response.Redirect("CustomerComponent.aspx");
                }
                else
                {
                    // Login failed
                    Response.Write("<script>alert('Invalid mobile number or password.');</script>");
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }
            finally
            {
                // Close connection
                sqlConnection.Close();
            }
        }
    }
}