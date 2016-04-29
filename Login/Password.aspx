
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Password.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div><h1><span>Automatic Password Generator</span> </h1>
        <table class="auto-style1">
            <tr>
                <td class="auto-style10">Last Name:&nbsp; </td>
                <td class="auto-style29">
            <asp:TextBox ID="txtLastName" runat="server" Width="200px" CausesValidation="True"></asp:TextBox>
                </td>
                <td class="auto-style31">
            <asp:RequiredFieldValidator ID="valLastNRequired" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is Required!" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style13">
                    &nbsp;</td>
                <td class="auto-style14"></td>
            </tr>
            <tr>
                <td class="auto-style10">Birth Year:&nbsp;&nbsp; </td>
                <td class="auto-style29"> <asp:TextBox ID="txtBirthYear" runat="server" Width="200px" CausesValidation="True"></asp:TextBox>
                </td>
                <td class="auto-style31">
            <asp:RequiredFieldValidator ID="valBirthYearRequired" runat="server" ControlToValidate="txtBirthYear" ErrorMessage="Birth Year is Required!" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style18">
            <asp:RegularExpressionValidator ID="vldBirthYearDigits" runat="server" ControlToValidate="txtBirthYear" ErrorMessage="Birth Year must be 4 digits!" ForeColor="Red" ValidationExpression="\d{4}"></asp:RegularExpressionValidator>
                </td>
                <td class="auto-style19">
                    <asp:RangeValidator ID="vldBirthYearRange" runat="server" ErrorMessage="Birth year must be between 1900 and 2016!" ForeColor="Red" MaximumValue="2016" MinimumValue="1900" ControlToValidate="txtBirthYear"></asp:RangeValidator>
                </td>
            </tr>
            </table>
        </div>
        <br />
        <table class="auto-style25">
            <tr>
                <td class="auto-style26">
        <asp:Button ID="btnSuggestPswdList" runat="server" OnClick="btnSuggestPswdList_Click" Text="Suggest Password List &gt;&gt;&gt;" Width="295px" />
                &nbsp;</td>
                <td class="auto-style33">
        <asp:ListBox ID="lstSuggestedPswdList" OnSelectedIndexChanged="lstSuggestedPswdList_SelectedIndexChanged" runat="server" Height="100px" Width="200px" AutoPostBack="True"></asp:ListBox>
                &nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <br />
        <asp:Label ID="lblConfirmation" runat="server" Visible="False"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnWelcomeLogin" runat="server" OnClick="btnWelcomeLogin_Click" style="background-color: #0066FF" Text="Welcome!  Please log in" Visible="False" Width="320px" />
        <br />
    </form>
</body>
</html>
