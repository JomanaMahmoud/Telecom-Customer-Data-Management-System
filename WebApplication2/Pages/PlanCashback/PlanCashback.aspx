<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlanCashback.aspx.cs" Inherits="WebApplication2.Pages.PlanCashback.PlanCashback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Plan Cashback
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <h2>Plan Cashback Amount</h2>
    <div>
        <p>Wallet ID:</p>
        <asp:TextBox ID="TextBoxWalletID" runat="server" CssClass="input-field"></asp:TextBox>
        <p>Plan ID:</p>
        <asp:TextBox ID="TextBoxPlanID" runat="server" CssClass="input-field"></asp:TextBox>
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" CssClass="action-button" />
        <p>
            <asp:Label ID="CashbackAmountLabel" runat="server"></asp:Label>
        </p>
        <p>
            <asp:Label ID="ErrorMessageLabel" runat="server" ForeColor="Red"></asp:Label> <%-- For error display --%>
        </p>
     </div>
</asp:Content>
