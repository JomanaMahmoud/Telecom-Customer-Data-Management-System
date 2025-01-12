<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdatePoints.aspx.cs" Inherits="WebApplication2.Pages.UpdatePoints.UpdatePoints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Update Points
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Update Earned Points</h2>
    <div>
        <p>Mobile Number:</p>
        <asp:TextBox ID="TextBoxMobileNumber" runat="server" CssClass="input-field"></asp:TextBox>
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" CssClass="action-button" />

        <p>
            <asp:Label ID="ErrorMessageLabel" runat="server" ForeColor="Red"></asp:Label> 
        </p>
        <p>
            <asp:Label ID="SuccessMessageLabel" runat="server" ForeColor="Green"></asp:Label>
        </p>

    </div>
</asp:Content>
