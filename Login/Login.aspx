<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
       
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1>Please Login</h1>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style9">UserName:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="txtUserName" runat="server" Width="200px"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                       <%-- <asp:RequiredFieldValidator ID="vldUserName" runat="server" ControlToValidate="txtUserName" ErrorMessage="Username is required! Please see your administrator" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">Password:</td>
                    <td class="auto-style8">
                        <asp:TextBox ID="txtPassword" runat="server" Width="200px" TextMode="Password"></asp:TextBox>
            
                    </td>
                    <td class="auto-style8">
                       <%-- <asp:RequiredFieldValidator ID="vldPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required!" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                        <asp:Label ID="lblVldPassword" runat="server" Text="Invalid Password,  Please see your administrator" ForeColor="Red" Visible="False"></asp:Label><br />

                    </td>
                </tr>
            </table>
        </div>
        <p>
            <asp:Button ID="btnLogin" runat="server" Text="Login" Width="70px" OnClick="btnLogin_Click" />

            <asp:Label ID="loginErrorLabel" runat="server" Visible="False"></asp:Label>
        </p>
    </form>
</body>
</html>
