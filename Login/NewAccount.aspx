<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewAccount.aspx.cs" Inherits="NewAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <style type="text/css">
        .auto-style1 {
            width: 463px;
            height: 70px;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>New Account Information</h1>
        <table class="auto-style1">
            <tr>
                <td class="auto-style21">First Name: </td>
                <td class="auto-style11">
            <asp:TextBox ID="txtFirstName" runat="server" CausesValidation="True" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style16">
            <asp:RequiredFieldValidator ID="valFirstNameRequired" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is Required!" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style12"></td>
            </tr>
            <tr>
                <td class="auto-style21">Last Name:&nbsp;&nbsp; </td>
                <td class="auto-style8"> <asp:TextBox ID="txtLastName" runat="server" CausesValidation="True" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style15">
            <asp:RequiredFieldValidator ID="valLastNameRequired" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is Required!" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style9"></td>
            </tr>
            <tr>
                <td class="auto-style21">&nbsp;</td>
                <td class="auto-style11">
                    &nbsp;</td>
                <td class="auto-style16">
                    &nbsp;</td>
                <td class="auto-style12">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style21">&nbsp;</td>
                <td class="auto-style2"> 
                </td>
                <td class="auto-style17"></td>
                <td class="auto-style13"></td>
            </tr>
        </table>
        <p>&nbsp;</p>
        <p>
            <asp:Button ID="btnCreateAcct" runat="server" OnClick="btnCreateAcct_Click" Text="Create Account" Width="250px" CausesValidation="False" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset" Width="150px" CausesValidation="False" />
        </p>
    </div>
    </form>
</body>
</html>
