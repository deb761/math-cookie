<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClassView.aspx.cs" Inherits="Solstice.ClassView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <title>Admin Home</title>
    <style>
        .block {
            display: inline-block;
            margin: 20px;
            vertical-align: top;
            /*width: 372px;*/
        }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="AdminHome.aspx">Users</a></li>
            <li><a href="ClassView.aspx">Class View</a></li>
            
        </ul>
    </nav>
    

    <form id="form1" runat="server">
    <div>
    <h2>Classes </h2>
        <br />
        <a href="AdminHome.aspx">Admin Home Page</a>
    </div>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ClassID" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="ClassName" HeaderText="Class Name" SortExpression="ClassName" />
                <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            </Columns>
        </asp:GridView>

        <h2>Details for
        <asp:Label ID="lblName" runat="server" Text="No Class Selected"></asp:Label> </h2>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="SELECT Classes.ClassName, SchoolYears.Name AS Year, Classes.ClassID, Users.FirstName, Users.LastName FROM Classes INNER JOIN Users ON Classes.TeacherID = Users.UserID INNER JOIN SchoolYears ON Classes.Year = SchoolYears.YearID"></asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="SELECT [FirstName], [LastName] FROM [Users] WHERE ([UserType] = @UserType)">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="UserType" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="SELECT Users.FirstName, Users.LastName, ClassStudents.UserID FROM ClassStudents INNER JOIN Users ON ClassStudents.UserID = Users.UserID WHERE (ClassStudents.ClassID = @classID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" DefaultValue="1" Name="classID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>

