<%@ Page Title="Customers with Plans" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomersWithPlans.aspx.cs" Inherits="WebApplication1.CustomersWithPlans" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Customers with Plans
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <style>

    .filter-container {
        margin-bottom: 20px;
    }

    .filter-container label {
        font-weight: bold;
        margin-right: 10px;
    }

    .filter-container input {
        padding: 8px;
        margin-right: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .filter-container button {
        padding: 8px 15px;
        background-color: #003366;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .filter-container button:hover {
        background-color: #00509e;
    }
    
    .grid-view th,
    .grid-view td {
        font-size: 14px;
    }
</style>


    <div>
        <h1>Customers With Plans</h1>

        <!-- Filter Section -->
       

        <!-- GridView -->
        <div class="gridview-container">
            <asp:GridView 
                ID="GridViewCustomersWithPlans" 
                runat="server" 
                AutoGenerateColumns="false" 
                GridLines="None"
                CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="mobileNo" HeaderText="Mobile No" />
                    <asp:BoundField DataField="pass" HeaderText="Pass" />
                    <asp:BoundField DataField="balance" HeaderText="Balance" />
                    <asp:BoundField DataField="account_type" HeaderText="Account Type" />
                    <asp:BoundField DataField="start_date" HeaderText="Start Date" />
                    <asp:BoundField DataField="status" HeaderText="Status" />
                    <asp:BoundField DataField="points" HeaderText="Points" />
                    <asp:BoundField DataField="nationalID" HeaderText="National ID" />
                    <asp:BoundField DataField="planID" HeaderText="Plan ID" />
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="price" HeaderText="Price" />
                    <asp:BoundField DataField="SMS_offered" HeaderText="SMS Offered" />
                    <asp:BoundField DataField="minutes_offered" HeaderText="Minutes Offered" />
                    <asp:BoundField DataField="data_offered" HeaderText="Data Offered" />
                    <asp:BoundField DataField="description" HeaderText="Description" />
                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>
