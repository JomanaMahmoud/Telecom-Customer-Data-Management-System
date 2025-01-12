<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AverageTransactions.aspx.cs" Inherits="WebApplication2.Pages.AverageTransactions.AverageTransactions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Average Transactions
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Average Transactions</h2>
    <div>
        <p>Wallet ID:</p>
        <asp:TextBox ID="TextBoxWalletID" runat="server" CssClass="input-field"></asp:TextBox>
        <p>Start Date:</p>
        <asp:TextBox ID="TextBoxStartDate" runat="server" TextMode="Date" CssClass="input-field"></asp:TextBox> <%-- New --%>
        <p>End Date:</p>
        <asp:TextBox ID="TextBoxEndDate" runat="server" TextMode="Date" CssClass="input-field"></asp:TextBox> <%-- New --%>
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" CssClass="action-button" />
        <p>
            <asp:Label ID="AverageAmountLabel" runat="server"></asp:Label> <%-- Changed ID --%>
        </p>
        <p>
            <asp:Label ID="ErrorMessageLabel" runat="server" ForeColor="Red"></asp:Label>
        </p>
     </div>
</asp:Content>
