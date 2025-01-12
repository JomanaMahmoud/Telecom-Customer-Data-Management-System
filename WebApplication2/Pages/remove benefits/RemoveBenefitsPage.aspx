<%@ Page Title="Remove Benefits" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RemoveBenefitsPage.aspx.cs" Inherits="WebApplication1.RemoveBenefitsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Remove Benefits
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div>
        <h2>Remove Benefits for an Account</h2>

        <!-- Input Fields -->
        <asp:Label ID="LabelMobileNo" runat="server" Text="Mobile Number: "></asp:Label>
        <asp:TextBox ID="TextBoxMobileNo" runat="server" MaxLength="11" CssClass="input-field"></asp:TextBox>

        <asp:Label ID="LabelPlanID" runat="server" Text="Plan ID: "></asp:Label>
        <asp:TextBox ID="TextBoxPlanID" runat="server" CssClass="input-field"></asp:TextBox>

        <!-- Action Button -->
        <asp:Button 
            ID="ButtonRemoveBenefits" 
            runat="server" 
            Text="Remove Benefits" 
            CssClass="action-button" 
            OnClick="ButtonRemoveBenefits_Click" />

        <!-- Status Message -->
        <asp:Label 
            ID="LabelStatus" 
            runat="server" 
            CssClass="status-message"></asp:Label>
    </div>
</asp:Content>
