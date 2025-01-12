<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MobileSearch.aspx.cs" Inherits="WebApplication2.Pages.MobileSearch.MobileSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Wallet Mobile Search
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Wallet Mobile Search</h2>
    <div>
        <p>Mobile Number:</p>
        <asp:TextBox ID="TextBoxMobileNumber" runat="server" CssClass="input-field"></asp:TextBox> <%-- Corrected ID and Label --%>
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" CssClass="action-button" />
        <p>
            <asp:Label ID="SearchResultLabel" runat="server"></asp:Label> <%-- Corrected ID --%>
        </p>
        <p>
            <asp:Label ID="ErrorMessageLabel" runat="server" ForeColor="Red"></asp:Label>
        </p>
    </div>

</asp:Content>
