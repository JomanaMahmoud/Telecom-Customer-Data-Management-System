<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PaymentPoints.aspx.cs" Inherits="WebApplication2.Pages.PaymentPoints.PaymentPoints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Payment Points
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Account Payment Points</h2>
    <div>
        <p>Account Mobile Number:</p>
        <asp:TextBox ID="TextBoxMobileNumber" runat="server" CssClass="input-field"></asp:TextBox>
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" CssClass="action-button"/>
        <asp:GridView ID="GridViewDetails" runat="server" CssClass="grid-view" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true">
            <EmptyDataTemplate>
                <p>No records found.</p>
            </EmptyDataTemplate>
        </asp:GridView>
        <p>
            <asp:Label ID="ErrorMessageLabel" runat="server" ForeColor="Red"></asp:Label> <%-- For error display --%>
        </p>
     </div>
</asp:Content>
