<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListSMSOffers.aspx.cs" Inherits="WebApplication1.ListSMSOffers" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    List SMS Offers
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
    <div>
        <h2>SMS Offers for Account</h2>

        <!-- Mobile Number Input -->
        <asp:Label ID="LabelMobileNo" runat="server" Text="Enter Mobile Number: "></asp:Label>
        <asp:TextBox ID="TextBoxMobileNo" runat="server" CssClass="input-field"></asp:TextBox>

        <!-- Fetch Offers Button -->
        <asp:Button ID="ButtonFetchOffers" runat="server" Text="Fetch Offers" OnClick="ButtonFetchOffers_Click" CssClass="action-button" />
        
        <br /><br />
        
        <!-- Status Label -->
        <asp:Label ID="LabelStatus" runat="server" CssClass="status-message"></asp:Label>

        <!-- GridView to Display SMS Offers -->
        <asp:GridView ID="GridViewOffers" runat="server" CssClass="grid-view" Visible="false" AutoGenerateColumns="True">
        </asp:GridView>
    </div>
</asp:Content>
