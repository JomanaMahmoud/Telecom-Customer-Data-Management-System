<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication2.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4fa3d1, #1c1c1c);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
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

        .login-container label {
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
            display: block;
            text-align: left;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 40px);
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .login-container input[type="text"]:focus,
        .login-container input[type="password"]:focus {
            outline: none;
            border-color: #2575fc;
        }

        .login-container input[type="submit"],
        .login-container .login-button {
            width: 60% !important; 
            background: #2575fc;
            border: none;
            padding: 12px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        /*.login-container input[type="submit"]:hover,*/
        .login-container .login-button:hover {
            background-color: #6a11cb;
        }

        .login-container .login-button:disabled {
            background-color: #2575fc; /* Original color */
            filter: brightness(0.8); /* Darkens the button */
            cursor: not-allowed;
        }

        .forgot-password {
            margin-top: 10px;
            font-size: 12px;
            color: #2575fc;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #2e4c5d;
            font-size: 14px;
            margin-top: 10px;
        }

        .customer-login-link {
            margin-top: 10px;  
            font-size: 17px;   
            color: #606060;  
        }

        .customer-login-link a {
            color: #2575fc;   
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
            color: #000;
        }

        .hint-popup-content {
            position: relative;
        }

        .close-btn {
            position: absolute;
            top: 1px;
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
            <h2>Customer Login</h2>
            <!-- Mobile Number Field -->
            <asp:TextBox ID="mnumber" runat="server" placeholder="Mobile Number" type="text" onkeyup="validateForm()"></asp:TextBox>

            <!-- Password Field -->
            <asp:TextBox ID="password" runat="server" placeholder="Password" type="password" onkeyup="validateForm()"></asp:TextBox>

            <!-- Login Button -->
            <div>
                <asp:Button ID="buttonlogin" runat="server" onclick="loginm" Text="Login" CssClass="login-button" Enabled="false" />
            </div>
            <br />
            <div>
            <asp:Label ID="lblError" runat="server" CssClass="error-message"></asp:Label>
            </div>
            <div class="customer-login-link">
                Are you an admin? <a href="/Pages/Login/Login.aspx">Go to admin login</a>
    </form>

    <div id="hintPopup" class="hint-popup">
        <div class="hint-popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <p><strong>Hint:</strong> Use Mobile Number: <em>01234567890</em> and Password: <em>pass</em> to log in.</p>
        </div>
    </div>

</body>
<script>
    // Function to show the pop-up
    function showPopup() {
        document.getElementById('hintPopup').style.display = 'block';
    }

    // Function to close the pop-up
    function closePopup() {
        document.getElementById('hintPopup').style.display = 'none';
        sessionStorage.setItem('closedCustomerLogin', 'true');
    }

    // Show the pop-up when the page loads
    window.onload = function () {
        localStorage.clear();
        // Check if the user is visiting for the first time in this session
        if (!sessionStorage.getItem('closedCustomerLogin')) {
            showPopup();
        }
    }

    // Function to validate the form
    function validateForm() {
        var mnumber = document.getElementById('<%= mnumber.ClientID %>').value;
    var password = document.getElementById('<%= password.ClientID %>').value;
        var buttonlogin = document.getElementById('<%= buttonlogin.ClientID %>');

        if (mnumber.trim() !== "" && password.trim() !== "") {
            buttonlogin.disabled = false;
            buttonlogin.style.cursor = 'pointer';
        } else {
            buttonlogin.disabled = true;
            buttonlogin.style.cursor = 'not-allowed';
        }
    }

</script>
</html>
