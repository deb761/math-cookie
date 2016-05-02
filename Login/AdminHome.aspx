<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminHome.aspx.cs" Inherits="AdminHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Teachers</h1>
        <asp:gridview runat="server" AllowSorting="True" CellPadding="4" 
            DataSourceID="TeacherDataSource" ForeColor="#333333" GridLines="None" 
            AutoGenerateColumns="False" ID="teacherGridView" DataKeyNames="UserID" 
            OnRowCommand="ShowUserDetails" AllowPaging="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:CommandField ButtonType="Link" showeditbutton="true" 
                    ShowDeleteButton="True" />
                <asp:ButtonField ButtonType="Button" CommandName="Details" Text="..." />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:gridview>  
        <asp:SqlDataSource ID="TeacherDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" 
            SelectCommand="SELECT [UserID], [Login], [FirstName], [LastName] FROM [Users] WHERE ([UserType] = @UserType)" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @original_UserID AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))" 
            InsertCommand="INSERT INTO [Users] ([Login], [FirstName], [LastName]) VALUES (@Login, @FirstName, @LastName)" 
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [Users] SET [Login] = @Login, [FirstName] = @FirstName, [LastName] = @LastName WHERE [UserID] = @original_UserID AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_UserID" Type="Int32" />
                <asp:Parameter Name="original_Login" Type="String" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Login" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="UserType" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Login" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="original_UserID" Type="Int32" />
                <asp:Parameter Name="original_Login" Type="String" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <h1>Students</h1>  
        <asp:gridview runat="server" AllowSorting="True" CellPadding="4" DataSourceID="StudentDataSource"
             ForeColor="#333333" GridLines="None" ID="studentGridView" 
            AutoGenerateColumns="False" DataKeyNames="UserID" 
            OnRowCommand="ShowUserDetails" AllowPaging="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:CommandField ButtonType="Link" showeditbutton="true" showdeletebutton="true" />
                <asp:ButtonField ButtonType="Button" CommandName="Details" Text="..." />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:gridview>    
        <asp:SqlDataSource ID="StudentDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" 
            SelectCommand="SELECT [UserID], [Login], [FirstName], [LastName] FROM [Users] WHERE ([UserType] = @UserType)" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @original_UserID AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))" 
            InsertCommand="INSERT INTO [Users] ([Login], [FirstName], [LastName]) VALUES (@Login, @FirstName, @LastName)" 
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [Users] SET [Login] = @Login, [FirstName] = @FirstName, [LastName] = @LastName WHERE [UserID] = @original_UserID AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_UserID" Type="Int32" />
                <asp:Parameter Name="original_Login" Type="String" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Login" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="UserType" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Login" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="original_UserID" Type="Int32" />
                <asp:Parameter Name="original_Login" Type="String" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <h1>Administrators</h1>  
        <asp:gridview runat="server" AllowSorting="True" CellPadding="4" DataSourceID="AdminDataSource"
             ForeColor="#333333" GridLines="None" ID="gridview2" OnRowCommand="ShowUserDetails"
            AutoGenerateColumns="False" DataKeyNames="UserID" AllowPaging="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                    SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" 
                    SortExpression="LastName" />
                <asp:CommandField ButtonType="Link" showeditbutton="true" />
                <asp:ButtonField ButtonType="Button" CommandName="Details" Text="..." />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:gridview>    
        <asp:SqlDataSource ID="AdminDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" 
            SelectCommand="SELECT [UserID], [Login], [FirstName], [LastName] FROM [Users] WHERE ([UserType] = @UserType)" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @original_UserID AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))" 
            InsertCommand="INSERT INTO [Users] ([Login], [FirstName], [LastName]) VALUES (@Login, @FirstName, @LastName)" 
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [Users] SET [Login] = @Login, [FirstName] = @FirstName, [LastName] = @LastName WHERE [UserID] = @original_UserID AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_UserID" Type="Int32" />
                <asp:Parameter Name="original_Login" Type="String" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Login" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="UserType" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Login" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="original_UserID" Type="Int32" />
                <asp:Parameter Name="original_Login" Type="String" />
                <asp:Parameter Name="original_FirstName" Type="String" />
                <asp:Parameter Name="original_LastName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
