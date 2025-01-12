<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sidebar.ascx.cs" Inherits="WebApplication2.Controls.WebUserControl1" %>
<ul>
    <li><a href="/Pages/Home/Home.aspx"><i class='bx bxs-home'></i><span>Dashboard</span></a></li>
    <li><a href="/Pages/Physical Stores/PhysicalStoresWithVouchers.aspx"><i class='bx bx-store-alt'></i><span>Physical Stores' Vouchers</span></a></li>
    <li><a href="/Pages/resolved tickets/Resolved Tickets.aspx"><i class='bx bx-list-check'></i><span>Resolved Tickets</span></a></li>
    <li><a href="/Pages/customer plans/CustomersWithPlans.aspx"><i class='bx bx-notepad'></i><span>Users with Service Plans</span></a></li>
    <li><a href="/Pages/SubscriptionOnDate/CustomerAccountsSubscribedOnInputIdAndDate.aspx"><i class='bx bx-calendar'></i><span>Subscription By Date</span></a></li>
    <li><a href="/Pages/account usage/AccountUsagePage.aspx"><i class='bx bx-bar-chart-alt-2'></i><span>Account Usage Page</span></a></li>
    <li><a href="/Pages/remove benefits/RemoveBenefitsPage.aspx"><i class='bx bx-x'></i><span>Remove Benefits Page</span></a></li>
    <li><a href="/Pages/SMS offers/ListSMSOffers.aspx"><i class='bx bx-chat'></i><span>List SMS Offers</span></a></li>
    <li><a href="/Pages/Wallets/Wallets.aspx"><i class='bx bx-wallet'></i><span>Wallets</span></a></li>
    <li><a href="/Pages/Eshops/Eshops.aspx"><i class='bx bx-shopping-bag' ></i><span>Eshop Details</span></a></li>
    <li><a href="/Pages/Transactions/Transactions.aspx"><i class='bx bxs-credit-card-alt' ></i><span>Transactions</span></a></li>
    <li><a href="/Pages/Cashbacks/Cashbacks.aspx"><i class='bx bx-dollar-circle'></i><span>Cashbacks</span></a></li>
    <li><a href="/Pages/PaymentPoints/PaymentPoints.aspx"><i class='bx bx-gift'></i><span>Payment Points</span></a></li>
    <li><a href="/Pages/PlanCashback/PlanCashback.aspx"><i class='bx bx-money'></i><span>Plan Cashback</span></a></li>
    <li><a href="/Pages/AverageTransactions/AverageTransactions.aspx"><i class='bx bx-line-chart'></i><span>Average Transactions</span></a></li>
    <li><a href="/Pages/MobileSearch/MobileSearch.aspx"><i class='bx bx-search-alt-2'></i><span>Wallet Mobile Search</span></a></li>
    <li><a href="/Pages/UpdatePoints/UpdatePoints.aspx"><i class='bx bx-sync' ></i><span>Update Points</span></a></li>
</ul>

<script type="text/javascript">
    // Get the current page URL
    var currentUrl = window.location.pathname;

    // Get all the sidebar links
    var sidebarLinks = document.querySelectorAll('#sidebar ul li a');

    // Loop through the links and check if the current URL matches
    for (var i = 0; i < sidebarLinks.length; i++) {
        var link = sidebarLinks[i];
        if (link.href.indexOf(currentUrl) > -1) {
            link.parentElement.classList.add("active");

            break; 
        }
    }
</script>