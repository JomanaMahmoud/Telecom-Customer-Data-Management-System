<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Eshops.aspx.cs" Inherits="WebApplication2.Pages.Eshops.Eshops" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Eshops
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <h2>E-Shops</h2>
        <asp:GridView ID="GridViewDetails" runat="server" CssClass="grid-view" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true">
            <EmptyDataTemplate>
                <p>No records found.</p>
            </EmptyDataTemplate>
        </asp:GridView>

</asp:Content>
