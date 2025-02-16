<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerComponent.aspx.cs" Inherits="Milestone_3.CustomerComponent" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Telecom Services</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Roboto:wght@700&display=swap" rel="stylesheet"> <!-- Added Roboto for Logo -->
    <style>
        /* Global Styles */
        body {
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff; /* Default light background */
            color: #333;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Light Mode */
        .light-mode {
            background-color: #ffffff;
            color: #333;
        }

        /* Dark Mode */
        .dark-mode {
            background-color: #121212; /* Dark background */
            color: #e0e0e0;
        }

        /* Header */
        header {
            background-color: #212121; /* Dark Gray */
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* Qualcomm-like font for Logo */
        header .logo {
            text-decoration: none;
            font-family: 'Roboto', sans-serif; /* Qualcomm-like font */
            font-size: 28px;
            font-weight: 700;
            color: #4fa3d1;
        }

        header .nav-links {
            margin-left: 400px;
            display: flex;
            gap: 20px;
            justify-content: flex-end;
        }
        header .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
        }
        header .nav-links a:hover {
            color: #61dafb; /* Light Blue */
        }

        /* Dark Mode Toggle Button */
        .dark-mode-toggle {
            background-color: transparent;
            border: none;
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
        }

        .dark-mode-toggle img {
            width: 30px;
            height: 30px;
        }

        /* Sidebar */
        .sidebar {
            width: 230px;
            background-color: #1c1c1c; /* Darker Gray */
            color: white;
            padding: 20px;
            border-radius: 8px;
            height: 100vh;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
            margin-right: 20px;
            transition: box-shadow 0.3s ease;
        }
        
        .sidebar:hover {
            box-shadow: 0 4px 20px rgba(100, 100, 100, 0.6); /* Slightly darker light grey shadow for hover in light mode */
        }

        .dark-mode .sidebar:hover {
            box-shadow: 0 4px 20px rgba(80, 80, 80, 0.5); /* Slightly darker shadow for hover in dark mode */
        }

        .sidebar h2 {
            font-size: 22px;
            margin-bottom: 20px;
        }

        .sidebar button {
            width: 100%;
            padding: 12px;
            background-color: #4fa3d1; /* Soft Blue */
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-bottom: 10px;
        }
        .sidebar button:hover {
            background-color: #367b98; /* Slightly Darker Blue */
        }

        /* Main Content */
        .main-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        /* Content Sections */
        .content {
            flex: 1;
            background-color: #fff;
            color: #333;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ccc; /* Light gray border for light mode */
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        /* Dark Mode Content Transition */
        .dark-mode .content {
            background-color: #202020; /* Dark Gray */
            color: #e0e0e0;
            border: 1px solid #202020; /* Lighter dark gray border */
        }

        .content:hover {
            box-shadow: 0 4px 20px rgba(80, 80, 80, 0.6); /* Slightly lighter grey shadow for hover in dark mode */
        }

        .content h2 {
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #606060; 
        }
         .dark-mode  .content h2 {
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #e0e0e0; 
        }

        .number-box {
            background-color: #4fa3d1;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            font-size: 22px;
            text-align: center;
            display: inline-block;
            margin-bottom: 20px;
            margin-right:  15px;
            font-weight:500;
        }
        .dark-mode .number-box {
            background-color: #4fa3d1;
            color: black;
            padding: 15px 20px;
            border-radius: 8px;
            font-size: 22px;
            text-align: center;
            display: inline-block;
            margin-bottom: 20px;
            font-weight:500;
        }

        /* Tables */
        .styled-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
            .dark-mode .styled-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.35);
        }
        .styled-table th, .styled-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 0.5px solid #ddd;
        }
        /* Styling for the first column (th or td) */
        .styled-table :first-child th{
        border-bottom:none;
        }
        .styled-table tr:last-child td {
         border-bottom: none;
        }
        .styled-table th {
            background-color: #1c1c1c;
            color: white;
            cursor: pointer;
        }

        /* Table Rows for Dark Mode */
        .dark-mode .styled-table tr {
            background-color: #252525; /* Darker grey for rows in dark mode */
        }

        .dark-mode .styled-table tr:first-child td {
         border-top: none;
        }

        .dark-mode .styled-table tr:last-child td {
         border-bottom: none;
        }
        .dark-mode .styled-table th, .styled-table td {
        padding: 15px;
        text-align: left;
        border-bottom: 0.5px solid #aaa;
        }
        .dark-mode .styled-table first-child td {
        padding: 15px;
        text-align: left;
        border-top: none;
        }
        .styled-table tr:hover {
            background-color: #c9c9c9;
            color:white;
        }
        .dark-mode .styled-table tr:hover {
            background-color: #c9c9c9;
            color:black;
        }

        /* Styled TextBox */
        .styled-textbox {
            width: 300px;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: all 0.3s;
        }

        .styled-textbox:focus {
            border-color: #0078d4;
            box-shadow: 0 0 5px rgba(0, 120, 212, 0.5);
        }

        .dark-mode .styled-textbox {
        color-scheme: dark;
        }

        body.dark-mode .styled-textbox {
            background-color: #2b2b40;
            color: #f0f0f0;
            border: 1px solid #555;
        }

        body.dark-mode .styled-textbox:focus {
            border-color: #5d85ff;
            box-shadow: 0 0 5px rgba(93, 133, 255, 0.5);
        }

        /* Styled Button */
        .styled-button {
            display: flex;
            width: 180px;
            padding: 10px;
            font-size: 16px;
            color: #fff;
            background-color: #111;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .styled-button:hover {
            background-color: #0c0c0c;
        }

        body.dark-mode .styled-button {
            color: #e0e0e0;
        }

        /* General dropdown styles */
        .styled-dropdown {
            width: 300px;
            padding: 10px;
            font-size: 16px;
            background-color: #fff;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 5px;
            appearance: none; /* Removes default arrow for consistency */
            -moz-appearance: none;
            -webkit-appearance: none;
            outline: none;
            cursor: pointer;
            transition: all 0.3s;
        }

        .styled-dropdown:focus {
            border-color: #0078d4;
            box-shadow: 0 0 5px rgba(0, 120, 212, 0.5);
        }

        /* Add custom arrow */
        .styled-dropdown {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" fill="%23333" height="24" viewBox="0 0 24 24" width="24"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px;
        }

        body.dark-mode .styled-dropdown {
            background-color: #2b2b40;
            color: #f0f0f0;
            border: 1px solid #555;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" fill="%23f0f0f0" height="24" viewBox="0 0 24 24" width="24"><path d="M7 10l5 5 5-5z"/></svg>');
        }

        body.dark-mode .styled-dropdown:focus {
            border-color: #5d85ff;
            box-shadow: 0 0 5px rgba(93, 133, 255, 0.5);
        }

        /* Placeholder style */
        .styled-dropdown option:first-child {
            color: #aaa;
        }

        body.dark-mode .styled-dropdown option:first-child {
            color: #666;
        }

        /* Optional hover effect */
        .styled-dropdown:hover {
            border-color: #0078d4;
        }

        body.dark-mode .styled-dropdown:hover {
            border-color: #5d85ff;
        }

        /* CTA Section */
        .cta-section {
            background-color: #4fa3d1; /* Soft Blue */
            color: #333;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        .cta-section button {
            background-color: #333;
            color: white;
            padding: 15px 20px;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .cta-section button:hover {
            background-color: #1c1c1c;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
            }
        }

        .hint-popup {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 300px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            z-index: 1000;
            display: none; /* Initially hidden */
        }

        .hint-popup-content {
            position: relative;
        }

        .close-btn {
            position: absolute;
            top: 1px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
            color: #333;
        }

        .close-btn:hover {
            color: #ff0000;
        }

        /* Dark mode styles for hint-popup */
        .dark-mode .hint-popup {
            background-color: #2b2b2b;
            border: 1px solid #555;
            color: #f0f0f0;
        }
        .dark-mode .hint-popup .close-btn {
            color: #f0f0f0;
        }
        .dark-mode .hint-popup .close-btn:hover {
            color: #ff0000;
        }
    </style>
</head>
<body class="light-mode">
    <header>
        <a class="logo" href="#" onclick="showSection('servicePlans')">Nexus</a>
        <div class="nav-links">
            <a href="#" onclick="showSection('renew-subscription')">Renew Subscription</a>
            <a href="#" onclick="showSection('highestVoucher')">Highest Voucher</a>
            <a href="#" onclick="showSection('unresolvedTickets')">Unresolved Tickets</a>
            <a href="#" onclick="showSection('remainingExtraAmount')">Remaining & Extra Amounts</a>
            <a href="mailto:yehiarasheed@gmail.com"> Support</a>
            <a href="/Customer/Pages/login.aspx" class="back-button" onclick="clearDarkModeState(); logout();">Log Out</a>
            
        </div>
        <!-- Dark Mode Toggle Button -->
        <button class="dark-mode-toggle" onclick="toggleDarkMode()">
            <img id="modeIcon" src="https://img.icons8.com/?size=100&id=59841&format=png&color=FFFFFF">
        </button>
    </header>

    <div class="main-container">
        <div class="sidebar">
            <h2>Account Overview</h2>
            <button onclick="showSection('servicePlans')">Service Plans</button>
            <button type="button" onclick="showSection('sms-minutes-internet')">SMS, Minutes & Internet</button>
            <button type="button" onclick="showSection('company-offered-plans')">Company Plans</button>
            <button type="button" onclick="showSection('active-plan-usage')">Active Plan Usage</button>
            <button type="button" onclick="showSection('cashback-section')">Cashback Transactions</button>
            <button onclick="showSection('allBenefits')">Active Benefits</button>
            <button onclick="showSection('Payments')">Payments</button>
            <button onclick="showSection('Shops')">Shops</button>
            <button onclick="showSection('subscribed-plans-five-months')">Service Plans Subscribed To In The Past 5 Months</button>
            <button onclick="showSection('get-cashback-amount')">Get Cashback Amount</button>
            <button onclick="showSection('recharge-balance')">Recharge Balance</button>
            <button onclick="showSection('redeem-voucher')">Redeem Voucher</button>
        </div>
        <div class="content" id="allBenefits">
            <h2>Active Benefits</h2>
            <asp:Label ID="lblBenefits" runat="server"></asp:Label>
        </div>

       <div class="content" id="Shops">
            <h2>Shop Details</h2>
            <asp:Label ID="lblShops" runat="server"></asp:Label>
        </div>
        <div id="subscribed-plans-five-months" class="content">
            <h2>Service Plans Subscribed To During The Past 5 Months</h2>
            <asp:Label ID="lblSubPlanfivemonths" runat="server"></asp:Label>
        </div>
        <div class="content" id="Payments">
            <h2>Payments</h2>
            <h3>Top 10 Successful Payments By Value</h3>
            <asp:Label ID="lblTopPayments" runat="server"></asp:Label>
            <!-- Top Payments Table will be inserted here -->
        </div>

        <div class="content" id="servicePlans">
            <h2>Service Plans</h2>
            <asp:Label ID="lblConsole" runat="server" CssClass="console" Visible="false"></asp:Label>
            <asp:Label ID="lblServicePlans" runat="server"></asp:Label>
        </div>
        <div id="company-offered-plans" class="content">
            <h2>Company Offered Plans</h2>
            <h3>Unsubscribed Plans</h3>
            <asp:Label ID="lblCompanyOfferedPlans" runat="server"></asp:Label>
        </div>
     <div id="active-plan-usage" class="content">
        <h2>Active Plan Usage for Current Month</h2>
        <asp:Label ID="lblPlanUsage" runat="server"></asp:Label>
    </div>
     <!-- SMS, Minutes, and Internet Consumption -->
     <div id="sms-minutes-internet" class="content">
         <h2>SMS, Minutes, and Internet Consumption</h2>
         <form id="form1" runat="server">
         <h3>Enter Plan Name: </h3>
         <asp:TextBox ID="planName" runat="server" placeholder="Enter Plan Name" CssClass="styled-textbox"></asp:TextBox>
         <br />
         <h3>Enter Start Date: </h3>
         <asp:TextBox ID="startDate" runat="server" TextMode="Date" placeholder="Start Date" CssClass="styled-textbox"></asp:TextBox>
         <br />
         <h3>Enter End Date: </h3>
         <asp:TextBox ID="endDate" runat="server" TextMode="Date" placeholder="End Date" CssClass="styled-textbox"></asp:TextBox>
         <br />
         <asp:Label ID="lblSMS" runat="server"></asp:Label>
         <asp:Label ID="lblMins" runat="server"></asp:Label>
         <asp:Label ID="lblInt" runat="server"></asp:Label>
         <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="styled-button" OnClick="SubmitButton_Click" />
     </div>
            <div id ="recharge-balance" class="content">
                 <h2>Recharge Balance</h2>
                <div>
                    <h3>Amount:</h3>
                    <asp:TextBox ID="txtRechargeAmount" runat="server" CssClass="styled-textbox" placeholder="Enter Amount"></asp:TextBox>
                </div>
                <div>
                    <h3>Payment Method:</h3>
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="styled-dropdown">
                        <asp:ListItem Text="Select Payment Method" Value="" />
                        <asp:ListItem Text="Credit" Value="credit" />
                        <asp:ListItem Text="Cash" Value="cash" />
                    </asp:DropDownList>
                </div>
                <br />
                <asp:Button ID="btnSubmitRecharge" runat="server" Text="Recharge" OnClick="RechargeBalance_Click" CssClass="styled-button" />
        </div>
           <div id="redeem-voucher" class="content">
                <h2>Redeem Voucher</h2>
                <div>
                    <h3>Voucher ID:</h3>
                    <asp:TextBox ID="txtVoucherID" runat="server" CssClass="styled-textbox" placeholder="Enter Voucher ID"></asp:TextBox>
                </div>
                <br />
                <asp:Button ID="btnSubmitRedeemVoucher" runat="server" CssClass="styled-button" Text="Redeem Voucher" OnClick="RedeemVoucher_Click" />
           </div>
           <div id="renew-subscription" class="content">
            <h2>Renew Subscription</h2>
                <div>
                    <h3>Plan ID:</h3>
                    <asp:TextBox ID="txtPlanID" runat="server" CssClass="styled-textbox" placeholder="Enter your Plan ID"></asp:TextBox>
                </div>
                <div>
                    <h3>Amount:</h3>
                    <asp:TextBox ID="txtRenewAmount" runat="server" CssClass="styled-textbox" placeholder="Enter Amount"></asp:TextBox>
                </div>
                <div>
                    <h3>Payment Method:</h3>
                    <asp:DropDownList ID="ddlRenewPaymentMethod" runat="server" CssClass="styled-dropdown">
                        <asp:ListItem Text="Select Payment Method" Value="" />
                        <asp:ListItem Text="Credit" Value="credit" />
                        <asp:ListItem Text="Cash" Value="cash" />
                    </asp:DropDownList>
                </div>
               <br />
                <asp:Button ID="btnSubmitRenewSubscription" runat="server" Text="Renew Subscription" OnClick="RenewSubscription_Click" CssClass="styled-button" />

        </div> 
    
       <div id="get-cashback-amount" class="content">
               <h2>Get Cashback Amount</h2>
                <div>
                    <h3>Payment ID:</h3>
                    <asp:TextBox ID="txtPaymentId" runat="server" CssClass="styled-textbox" placeholder="Enter Payment ID"></asp:TextBox>
                </div>
                <div>
                    <h3>Benefit ID:</h3>
                    <asp:TextBox ID="txtBenefitId" runat="server" CssClass="styled-textbox" placeholder="Enter Benefit ID"></asp:TextBox>
                </div>
                <br />
                <asp:Button ID="btnSubmitCashback" runat="server" CssClass="styled-button" Text="Get Cashback Amount" OnClick="GetCashbackAmount_Click" />
        </div>
     <!-- Cashback Section -->
    <div id="cashback-section" class="content">
       <h2>View Cashback Transactions</h2>
       <h3>Enter your National ID:</h3>
       <asp:TextBox ID="TextBoxNationalID" runat="server" Placeholder="Enter your National ID" CssClass="styled-textbox"></asp:TextBox>
       <asp:Button ID="ButtonFetchCashback" runat="server" Text="Fetch" 
                OnClick="btnSubmit_Cashback" CssClass="styled-button" />
        <asp:Label ID="lblCashbackStatus" runat="server"></asp:Label>
    </div>
     <div class="content" id="remainingExtraAmount">
         <h2>View Remaining And Extra Amounts</h2>
         <h3>Enter Plan Name</h3>
        <asp:TextBox ID="txtPlanName" runat="server" Placeholder="Enter Plan Name" CssClass="styled-textbox"></asp:TextBox>
         <asp:Button ID="ButtonRemainingExtraAmount" runat="server" Text="Submit" CssClass="styled-button" OnClick="btnSubmit_RemainingExtraAmount" />
    <br />
    <div style="display: flex; justify-content: start; align-items: start; gap: 40px; text-align: center;">
    <div style="display: flex; align-items: center; gap: 10px;">
        <h2 style="margin: 0;">Extra Amount:</h2>
      <asp:Label ID="lblExtraAmount" runat="server"></asp:Label>
    </div>
    <div style="display: flex; align-items: center; gap: 10px;">
      <h2 style="margin: 0;">Remaining Amount:</h2>
      <asp:Label ID="lblRemainingAmount" runat="server"></asp:Label> 
    </div> 
    </div>
     </div>
        <div class="content" id="unresolvedTickets">
            <h2>Unresolved Technical Support Tickets</h2>
            <h3>Enter your National ID:</h3>
                 <asp:TextBox ID="txtNationalID" runat="server" CssClass="styled-textbox" Placeholder="Enter your National ID"/>
                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Tickets" CssClass="styled-button"/>
            </form>
            <br>
            <asp:Label ID="lblTickets" runat="server"></asp:Label>
        </div>

        <div class="content" id="highestVoucher">
            <h2>Highest Voucher By Value</h2>
            <asp:Label ID="lblHighestVoucher" runat="server"></asp:Label>
        </div>

    </div>


    <div class="cta-section">
        <h3>Need Help?</h3>
        <p>If you have any questions, feel free to contact support.</p>
        <button onclick="window.location.href='mailto:yehiarasheed@gmail.com'">Contact Support</button>
    </div>

    <script>

        function showSection(id) {
            document.querySelectorAll('.content').forEach(el => el.style.display = 'none');
            document.getElementById(id).style.display = 'block';
    
            // Save the current section to localStorage
            localStorage.setItem('activeSection', id);
        }


        // Dark Mode Toggle
        function toggleDarkMode() {
            const body = document.body;
            body.classList.toggle('dark-mode');

            // Change the mode icon
            const icon = document.getElementById('modeIcon');
            if (body.classList.contains('dark-mode')) {
                icon.src = "https://img.icons8.com/?size=100&id=83221&format=png&color=FAB005"; // Sun for light mode
                sessionStorage.setItem('darkMode', 'true'); // Save dark mode state
            } else {
                icon.src = "https://img.icons8.com/?size=100&id=59841&format=png&color=FFFFFF"; // Half Moon for dark mode
                sessionStorage.removeItem('darkMode'); // Remove dark mode state
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            // Check if dark mode is enabled in sessionStorage
            if (sessionStorage.getItem("darkMode") === "true") {
                document.body.classList.add("dark-mode");
                document.body.classList.remove("light-mode");
                document.getElementById('modeIcon').src = "https://img.icons8.com/?size=100&id=83221&format=png&color=FAB005"; // Sun for light mode
            } else {
                document.body.classList.add("light-mode");
                document.body.classList.remove("dark-mode");
                document.getElementById('modeIcon').src = "https://img.icons8.com/?size=100&id=59841&format=png&color=FFFFFF"; // Half Moon for dark mode
            }
        });

        // Function to clear dark-mode state
        function clearDarkModeState() {
            sessionStorage.removeItem('darkMode');
        }

        window.addEventListener('load', function () {
            if (sessionStorage.getItem('darkMode') === 'enabled') {
                document.body.classList.add('dark-mode');
            }
        });

        // Sortable Table Functionality
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.styled-table th').forEach(function (th) {
                th.addEventListener('click', function () {
                    let table = th.closest('table');
                    let rows = Array.from(table.querySelector('tbody').rows);
                    let index = Array.from(th.parentElement.children).indexOf(th);
                    let ascending = th.dataset.sort !== 'asc';

                    rows.sort(function (rowA, rowB) {
                        // Preprocess cell values to exclude "$" and " GB"
                        let cellA = rowA.cells[index].innerText.trim().replace('$', '').replace(' GB', '');
                        let cellB = rowB.cells[index].innerText.trim().replace('$', '').replace(' GB', '');

                        // If values are numeric, compare as numbers; otherwise, compare as strings
                        if (!isNaN(cellA) && !isNaN(cellB)) {
                            return ascending ? cellA - cellB : cellB - cellA;
                        } else {
                            return ascending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
                        }
                    });

                    th.dataset.sort = ascending ? 'asc' : 'desc';
                    rows.forEach(function (row) {
                        table.querySelector('tbody').appendChild(row);
                    });
                });
            });
        });

        document.addEventListener("DOMContentLoaded", function () {
            const activeSection = localStorage.getItem('activeSection') || 'servicePlans';
            showSection(activeSection);
        });

        function logout() {
            // Clear the active section
            sessionStorage.removeItem('activeSection');
        }

        // Function to show the pop-up
        function showPopup() {
            document.getElementById('hintPopup').style.display = 'block';
        }

        // Function to close the pop-up
        function closePopup() {
            document.getElementById('hintPopup').style.display = 'none';
            sessionStorage.setItem('closedCustomer', 'true');
        }

        // Show the pop-up when the page loads
        window.onload = function () {
            // Check if the user is visiting for the first time in this session
            if (!sessionStorage.getItem('closedCustomer')) {
                showPopup();
            }
        }

    </script>

    <div id="hintPopup" class="hint-popup">
        <div class="hint-popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <p><strong>Hint:</strong> Use National ID: <em>1234567</em> Additionally, refer to the Service Plans section to find Plan IDs as needed to access relevant features.</p>
        </div>
    </div>

</body>
</html>