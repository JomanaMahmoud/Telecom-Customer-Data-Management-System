<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerAccountsSubscribedOnInputIdAndDate.aspx.cs" Inherits="WebApplication2.Pages.SubscriptionOnDate.CustomerAccountsSubscribedOnInputIdAndDate" MasterPageFile="~/Site.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Customers Subscribed on Date
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
        <h1>Customer Accounts Subscribed on Date</h1>

        <!-- Filter Section -->
        <div class="filter-container">
            <label for="planId">Plan ID:</label>
            <asp:TextBox ID="txtplanId" runat="server" />

            <label for="subscriptionDate">Subscription Date:</label>
            <asp:TextBox ID="txtsubscriptionDate" runat="server" TextMode="Date" />

            <asp:Button ID="FetchButton" runat="server" Text="Fetch" OnClick="FetchButton_Click" CssClass="action-button"/>
        </div>

        <!-- GridView to display results -->
        <div class="gridview-container">
            <asp:GridView ID="GridViewAccounts" runat="server" AutoGenerateColumns="false" GridLines="None" CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="mobileNo" HeaderText="Mobile No" />
                    <asp:BoundField DataField="planID" HeaderText="Plan ID" />
                    <asp:BoundField DataField="name" HeaderText="Plan Name" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
