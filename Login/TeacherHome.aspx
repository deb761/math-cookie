<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherHome.aspx.cs" Inherits="TeacherHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Class Overview</h1>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ResultDataSource"></asp:GridView>
        <asp:Button ID="btnLogoff" runat="server" OnClick="btnLogoff_Click" Text="Logoff" />
        <asp:SqlDataSource ID="ResultDataSource" runat="server"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
