<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Logout.aspx.cs" Inherits="Logout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1 class="auto-style1">You are successfully logged out!</h1>
        <p>
            <asp:Button ID="btnLoginAgain" runat="server" OnClick="btnLoginAgain_Click" Text="Login Again" Width="215px" />
        </p>  
    </div>
    </form>
</body>
</html>
