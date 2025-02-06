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
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
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
            border-color: #2575fc;
            outline: none;
        }

        .login-container input[type="submit"],
        .login-container .login-button {
            width: 60%;
            background-color: #2575fc;
            border: none;
            padding: 12px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-container input[type="submit"]:hover,
        .login-container .login-button:hover {
            background-color: #6a11cb;
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

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>Customer Login</h2>
            
            <!-- Mobile Number Field -->
            <label for="mnumber">Account Mobile Number:</label>
            <asp:TextBox ID="mnumber" runat="server" placeholder="Enter your Mobile Number" type="text"></asp:TextBox>

            <!-- Password Field -->
            <label for="password">Password:</label>
            <asp:TextBox ID="password" runat="server" placeholder="Enter your Password" type="password"></asp:TextBox>

            <!-- Login Button -->
            <div>
            <asp:Button ID="buttonlogin" runat="server" onclick="loginm" Text="Login" CssClass="login-button" />
            </div>
            <br />
            <div class="customer-login-link">
                Are you a admin? <a href="/Pages/Login/Login.aspx">Go to admin login</a>
            </div>
    </form>
</body>
</html>
