<%@ Page Title="Resolved Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResolvedTickets.aspx.cs" Inherits="WebApplication1.Resolved_Tickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Resolved Tickets
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h1>Resolved Tickets</h1>



        <!-- GridView for Resolved Tickets -->
        <div class="gridview-container">
            <asp:GridView 
                ID="GridViewResolvedTickets" 
                runat="server" 
                AutoGenerateColumns="true" 
                GridLines="None"
                CssClass="grid-view">
            </asp:GridView>
        </div>

       
    </div>
</asp:Content>
