<%@ Page Title="Physical Stores with Vouchers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PhysicalStoresWithVouchers.aspx.cs" Inherits="WebApplication2.PhysicalStoresWithVouchers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Physical Stores with Vouchers
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    

    <div >
        <h1>Physical Stores with Vouchers</h1>

        
        <!-- GridView -->
            <asp:GridView 
                ID="GridViewStoresWithVouchers" 
                runat="server" 
                AutoGenerateColumns="true" 
                GridLines="None"
                CssClass="grid-view">
                <EmptyDataTemplate>
                    <p>No records found.</p>
                </EmptyDataTemplate>
            </asp:GridView>

    </div>
</asp:Content>
