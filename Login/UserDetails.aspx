<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDetails.aspx.cs" Inherits="UserDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<asp:detailsview runat="server" height="50px" width="125px" AllowPaging="True" 
            AutoGenerateRows="False" DataKeyNames="UserID" 
            DataSourceID="SolsticeDataSource">
    <Fields>
        <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" 
            ReadOnly="True" SortExpression="UserID" />
        <asp:BoundField DataField="UserType" HeaderText="UserType" 
            SortExpression="UserType" />
        <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
        <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
            SortExpression="FirstName" />
        <asp:BoundField DataField="LastName" HeaderText="LastName" 
            SortExpression="LastName" />
    </Fields>
        </asp:detailsview>    
        <asp:SqlDataSource ID="SolsticeDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" 
            SelectCommand="SELECT [UserID], [UserType], [Login], [FirstName], [LastName] FROM [Users]">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
