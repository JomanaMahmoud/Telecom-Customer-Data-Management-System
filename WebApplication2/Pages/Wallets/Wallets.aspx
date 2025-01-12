<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wallets.aspx.cs" Inherits="WebApplication2.Pages.Wallets.Wallets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Wallets
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Wallet Details</h1>

        <!-- GridView -->
        <asp:GridView 
            ID="WalletsGridView" 
            runat="server" 
            CssClass="grid-view" 
            AutoGenerateColumns="false" 
            ShowHeaderWhenEmpty="true"
            GridLines="None">
            <Columns>
                <asp:BoundField DataField="walletID" HeaderText="Wallet ID" />
                <asp:BoundField DataField="current_balance" HeaderText="Current Balance" />
                <asp:BoundField DataField="currency" HeaderText="Currency" />
                <asp:BoundField DataField="last_modified_date" HeaderText="Last Modified Date" />
                <asp:BoundField DataField="nationalID" HeaderText="National ID" />
                <asp:BoundField DataField="mobileNo" HeaderText="Mobile No" />
                <asp:BoundField DataField="first_name" HeaderText="First Name" />
                <asp:BoundField DataField="last_name" HeaderText="Last Name" />
            </Columns>
            <EmptyDataTemplate>
                <p>No records found.</p>
            </EmptyDataTemplate>
        </asp:GridView>

    </div>
</asp:Content>
