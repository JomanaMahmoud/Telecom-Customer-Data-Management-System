<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="WebApplication2.Pages.Transactions.Transactions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Payment Transactions
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Payment Transactions</h2>
    <asp:GridView ID="GridViewDetails" runat="server" CssClass="grid-view" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true">
        <EmptyDataTemplate>
            <p>No records found.</p>
        </EmptyDataTemplate>
    </asp:GridView>
</asp:Content>
