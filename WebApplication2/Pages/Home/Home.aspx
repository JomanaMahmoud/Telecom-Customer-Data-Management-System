<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebApplication2.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Admin Page
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header" runat="server">
    <h1>Welcome to the Admin Page </h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <h2>All Customer Accounts</h2>
            <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="nationalID" HeaderText="National ID" />
                    <asp:BoundField DataField="first_name" HeaderText="First Name" />
                    <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="address" HeaderText="Address" />
                    <asp:BoundField DataField="date_of_birth" HeaderText="Date of Birth" />
                    <asp:BoundField DataField="mobileNo" HeaderText="Mobile No" />
                    <asp:BoundField DataField="account_type" HeaderText="Account Type" />
                    <asp:BoundField DataField="status" HeaderText="Status" />
                    <asp:BoundField DataField="start_date" HeaderText="Start Date" />
                    <asp:BoundField DataField="balance" HeaderText="Balance" />
                    <asp:BoundField DataField="points" HeaderText="Points" />
                </Columns>
            </asp:GridView>

</asp:Content>
