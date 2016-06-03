<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SecretSeedDatabase.aspx.cs" Inherits="SecretSeedDatabase" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Welcome, Super User!</h1>
        <asp:Button ID="btnUpdate" runat="server" Text="Update DB for Release2" OnClick="btnUpdate_Click" />
        <asp:Button ID="btnSeed" runat="server" Text="Seed Database" OnClick="btnSeed_Click" Enabled="False" />
        <asp:Button ID="btnProblems" runat="server" OnClick="btnProblems_Click" Text="Fill Problems" />
        <asp:Label ID="lblNotify" runat="server" Text="Select an action or go to any page"></asp:Label>
    </div>
    </form>
</body>
</html>
