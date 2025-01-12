<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountUsagePage.aspx.cs" 
    Inherits="WebApplication1.AccountUsagePage" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Account Usage By Plan
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div>
        <h2>Account Usage By Plan</h2>
        
        <!-- Input Fields -->
        <asp:Label ID="LabelMobileNo" runat="server" Text="Mobile Number: "></asp:Label>
        <asp:TextBox ID="TextBoxMobileNo" runat="server" MaxLength="11" CssClass="input-field"></asp:TextBox>
        <br />
        <asp:Label ID="LabelFromDate" runat="server" Text="From Date (YYYY-MM-DD): "></asp:Label>
        <asp:TextBox ID="TextBoxFromDate" runat="server" CssClass="input-field"></asp:TextBox>
        <br />
        <asp:Button ID="ButtonShowUsage" runat="server" Text="Show Usage" OnClick="ButtonShowUsage_Click" CssClass="action-button" />

        <!-- Error Message -->
        <asp:Label ID="LabelError" runat="server" CssClass="status-message"></asp:Label>

        <!-- GridView to Display Results -->
        <asp:GridView ID="GridViewAccountUsage" runat="server" CssClass="grid-view" AutoGenerateColumns="true">
        </asp:GridView>
    </div>
</asp:Content>
