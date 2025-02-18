<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication2.Pages.Login.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');
        body {
            font-family: 'Poppins', Arial, sans-serif;
           background: linear-gradient(to bottom, black 40%, #AD1457 100%);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            text-align: center;
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 300px;
        }
        .login-container h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
        }
        .login-container input {
            width: calc(100% - 40px);
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .login-container input:focus {
            outline: none;
            border-color: #E91E63;
        }
        .login-button {
            width: 60% !important; 
            background: #E91E63;
            border: none;
            padding: 12px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        .login-button:hover {
            background: #D81B60; 
        }

        .login-button:disabled {
        background-color: #E91E63; /* Original color */
        filter: brightness(0.8);
        cursor: not-allowed;
        }

        .error-message {
            color: #E91E63;
            font-size: 14px;
            margin-top: 10px;
        }

        .password-container {
            position: relative;
        }

        .password-container input {
            width: calc(100% - 40px);
            padding-right: 40px;
        }

        .password-container .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            color: #E91E63;
        }

        
        .customer-login-link {
            margin-top: 10px;  
            font-size: 17px;   
            color: #606060;  
        }

        .customer-login-link a {
            color: #E91E63;   
            text-decoration: none;
        }

        .customer-login-link a:hover {
            text-decoration: underline; 
        }

        .hint-popup {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 300px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            z-index: 1000;
            display: none; /* Initially hidden */
        }

        .hint-popup-content {
            position: relative;
        }

        .close-btn {
            position: absolute;
            top: 17px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
            color: #333;
        }

        .close-btn:hover {
            color: #ff0000;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server" class="login-container">
        <h2>Admin Login</h2>
        <input id="txtUsername" runat="server" type="text" placeholder="AdminID" onkeyup="validateForm()" />
        <br />
        <input id="txtPassword" runat="server" type="password" placeholder="Password" onkeyup="validateForm()" />
        <br />
        <asp:Button ID="btnLogin" runat="server" CssClass="login-button" Text="Login" OnClick="LoginButton" Enabled="false" />
        <div>
        <asp:Label ID="lblError" runat="server" CssClass="error-message"></asp:Label>
        </div>
        
        <div class="customer-login-link">
        Are you a customer? <a href="/Customer/Pages/login.aspx">Go to customer login</a>
        </div>

        <div id="hintPopup" class="hint-popup">
            <div class="hint-popup-content">
                <span class="close-btn" onclick="closePopup()">&times;</span>
                <p><strong>Hint:</strong> Use Admin ID: <em>58-12345</em> and Password: <em>admin</em> to log in.</p>
            </div>
        </div>
    </form>
</body>
<script>
    // Function to show the pop-up
    function showPopup() {
        document.getElementById('hintPopup').style.display = 'block';
    }

    // Function to close the pop-up
    function closePopup() {
        document.getElementById('hintPopup').style.display = 'none';
        sessionStorage.setItem('closedAdmin', 'true');
    }

    // Show the pop-up when the page loads
    window.onload = function () {
        localStorage.clear();
        // Check if the user is visiting for the first time in this session
        if (!sessionStorage.getItem('closedAdmin')) {
            showPopup();
        }
    }

    // Function to validate the form
    function validateForm() {
        var txtUsername = document.getElementById('<%= txtUsername.ClientID %>').value;
        var txtPassword = document.getElementById('<%= txtPassword.ClientID %>').value;
        var buttonlogin = document.getElementById('<%= btnLogin.ClientID %>');

        if (txtUsername.trim() !== "" && txtPassword.trim() !== "") {
            btnLogin.disabled = false;
            btnLogin.style.cursor = 'pointer';
        } else {
            btnLogin.disabled = true;
            btnLogin.style.cursor = 'not-allowed';
        }
    }
</script>
</html>
