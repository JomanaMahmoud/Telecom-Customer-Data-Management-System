<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cashbacks.aspx.cs" Inherits="WebApplication2.Pages.Cashbacks.Cashbacks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Cashbacks
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cashbacks</h2>
    <asp:GridView ID="GridViewDetails" runat="server" CssClass="grid-view" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true">
        <EmptyDataTemplate>
            <p>No records found.</p>
        </EmptyDataTemplate>
    </asp:GridView>
</asp:Content>
