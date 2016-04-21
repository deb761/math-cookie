<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="Welcome" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome</title>
</head>
<body style="background-color: #DDDBB5">
    <form id="form1" runat="server">
    <div>
        <p>
            <asp:Label ID="lblCurrentDateTime" runat="server"></asp:Label>
        </p>
        <h1 style="color: #000099">Welcome to the Machine, 
            <asp:Label ID="lblVisitorName" runat="server"></asp:Label>
            !</h1>
        <p>
            <asp:GridView ID="ian" runat="server">
            </asp:GridView>
        </p>
        <br />
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" Width="90px" OnClick="btnRefresh_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnLogout" runat="server" Text="Logout" Width="90px" OnClick="btnLogout_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnSave" runat="server" Text="Save Data" Width="90px" OnClick="btnSave_Click2" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lbXmlFile" runat="server" Visible="False"></asp:Label>
    </div>
    </form>
</body>
</html>
