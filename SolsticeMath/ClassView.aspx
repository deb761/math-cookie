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
        }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="AdminHome.aspx">Users</a></li>
            <li><a href="ClassView.aspx">Classes</a></li>            
        </ul>
    </nav>
    

    <form id="form1" runat="server">
    <div>
    <h1>Classes</h1>
        <asp:SqlDataSource ID="yearDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
            SelectCommand="SELECT * FROM [SchoolYears] ORDER BY [Start]"></asp:SqlDataSource>
    </div>
        <asp:GridView ID="classesGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ClassID"
            DataSourceID="classesDataSource" OnSelectedIndexChanged="classesGridView_SelectedIndexChanged" showfooter="True" >
            <Columns>
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Year" SortExpression="Year">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Year") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                       <asp:DropDownList ID="ddlYear" runat="server" DataSourceID="YearDataSource" DataTextField="Name"
                            DataValueField="YearID" SelectedValue='<%# Bind("YearID") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="YearDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT YearID, Name FROM SchoolYears ORDER BY Start">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <footerTemplate>
                       <asp:DropDownList ID="ddlYear" runat="server" DataSourceID="YearDataSource" DataTextField="Name"
                            DataValueField="YearID" SelectedValue='<%# Bind("YearID") %>' AppendDataBoundItems="true">
                            <asp:ListItem Text="---Select---" Value="0" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="YearDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT YearID, Name FROM SchoolYears ORDER BY Start">
                        </asp:SqlDataSource>
                    </footerTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="ClassName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ClassName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("ClassName") %>'></asp:Label>
                    </ItemTemplate>
                    <footerTemplate>
                        <asp:TextBox ID="txtClassName" runat="server" Text=''></asp:TextBox>
                    </footerTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Room" SortExpression="Room">
                    <EditItemTemplate>
                       <asp:DropDownList ID="ddlRoom" runat="server" DataSourceID="RoomDataSource" DataTextField="RoomName"
                            DataValueField="RoomID" SelectedValue='<%# Bind("RoomID") %>'>
                            <asp:ListItem Text="---Select---" Value="0" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="RoomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT RoomID, RoomName FROM Rooms ORDER BY RoomName">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <footerTemplate>
                        <asp:DropDownList ID="ddlRoom" runat="server" DataSourceID="RoomDataSource" DataTextField="RoomName"
                            DataValueField="RoomID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="RoomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT RoomID, RoomName FROM Rooms ORDER BY RoomName">
                        </asp:SqlDataSource>
                    </footerTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Room") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Teacher" SortExpression="Teacher">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlTeacher" runat="server" DataSourceID="UserDataSource" DataTextField="Name"
                            DataValueField="UserID" SelectedValue='<%# Bind("TeacherID") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT Users.UserID, Users.FirstName + ' ' + Users.LastName AS Name FROM Users WHERE (UserType = 1) ORDER BY LastName">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <FooterTemplate>
                       <asp:DropDownList ID="ddlTeacher" runat="server" DataSourceID="UserDataSource" DataTextField="Name" DataValueField="UserID" AppendDataBoundItems="true">
                            <asp:ListItem Text="---Select---" Value="0" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT Users.UserID, Users.FirstName + ' ' + Users.LastName AS Name FROM Users WHERE (UserType = 1) ORDER BY LastName">
                        </asp:SqlDataSource>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Teacher") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:LinkButton ID="btnAddClass" runat="server" OnClick="btnAddClass_Click">Add</asp:LinkButton>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"
                            OnClientClick="return confirm('Are you sure?');" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="classesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" 
            SelectCommand="SELECT Classes.ClassName, Rooms.RoomName AS Room, SchoolYears.Name AS Year,
            Classes.ClassID, Classes.YearID, Classes.TeacherID, Classes.RoomID,
            Users.FirstName + ' ' + Users.LastName AS Teacher
            FROM Classes
            INNER JOIN Users ON Classes.TeacherID = Users.UserID
            INNER JOIN SchoolYears ON Classes.YearID = SchoolYears.YearID
            INNER JOIN Rooms ON Classes.RoomID = Rooms.RoomID"
            DeleteCommand="DELETE FROM Classes WHERE (ClassID = @classID)"
            InsertCommand="INSERT INTO ClassStudents(UserID, ClassID) VALUES (@userID, @classID)"
            UpdateCommand="UPDATE Classes SET YearID=@yearID, TeacherID=@teacherID, ClassName=@className, RoomID=@roomID WHERE ClassID = @classID">
            <DeleteParameters>
                <asp:ControlParameter ControlID="classesGridView" Name="classID" PropertyName="SelectedValue" Type="Int32"/>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userID" />
                <asp:Parameter Name="classID" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="yearID" Type="Int32"/>
                <asp:Parameter Name="teacherID" Type="Int32"/>
                <asp:Parameter Name="className" Type="String" />
                <asp:Parameter Name="roomID" Type="Int32"/>
                <asp:Parameter Name="classID" Type="Int32"/>
            </UpdateParameters>
        </asp:SqlDataSource>
        <h2><asp:Label ID="lblClass" runat="server" Text="No Class Selected"></asp:Label></h2>
        
        <asp:ListView ID="classListView" runat="server" DataSourceID="classStudentsDataSource" InsertItemPosition="LastItem"
            DataKeyNames="UserID" OnItemInserting="classListView_ItemInserting">
            <AlternatingItemTemplate>
                <tr class="gridalt">
                    <td>
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure?');" />
                    </td>
                    <td>
                        <asp:Label ID="LoginLabel" runat="server" Text='<%# Eval("Login") %>' />
                    </td>
                    <td>
                        <asp:Label ID="StudentLabel" runat="server" Text='<%# Eval("Student") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EmptyDataTemplate>
                <table>
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr class="gridrow">
                    <td>
                        <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlStudent" runat="server" DataSourceID="UserDataSource" DataTextField="Name" DataValueField="UserID" AppendDataBoundItems="true" >
                            <asp:ListItem Text="---Select---" Value="0" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT Users.UserID, Users.FirstName + ' ' + Users.LastName AS Name
                            FROM Users
                            WHERE @classID NOT IN (SELECT ClassID
								FROM ClassStudents
								WHERE UserID = Users.UserID) AND Users.UserType = 0
							ORDER BY Name">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="classesGridView" Name="classID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr class="gridrow">
                    <td>
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure?');"/>
                    </td>
                    <td>
                        <asp:Label ID="LoginLabel" runat="server" Text='<%# Eval("Login") %>' />
                    </td>
                    <td>
                        <asp:Label ID="StudentLabel" runat="server" Text='<%# Eval("Student") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server" class="placeholder">
                            <table id="itemPlaceholderContainer" runat="server" >
                                <tr runat="server" class="gridheader">
                                    <th runat="server"></th>
                                    <th runat="server">Login</th>
                                    <th runat="server">Student</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr>
                    <td>
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                    </td>
                    <td>
                        <asp:Label ID="LoginLabel" runat="server" Text='<%# Eval("Login") %>' />
                    </td>
                    <td>
                        <asp:Label ID="StudentLabel" runat="server" Text='<%# Eval("Student") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        
        <asp:SqlDataSource ID="studentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="SELECT Users.FirstName + ' ' + Users.LastName AS Name
            FROM Users 
            INNER JOIN ClassStudents ON Users.UserID = ClassStudents.UserID
            INNER JOIN Classes ON ClassStudents.ClassID = Classes.ClassID
            WHERE (Users.UserType = 0) AND (Classes.ClassID &lt;&gt; @classID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="classesGridView" Name="classID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
        <asp:SqlDataSource ID="classStudentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
            SelectCommand="SELECT Users.Login, Users.FirstName + ' ' + Users.LastName AS Student, ClassStudents.UserID
                FROM ClassStudents
                INNER JOIN Users ON ClassStudents.UserID = Users.UserID
                WHERE (ClassStudents.ClassID = @classID)"
            DeleteCommand="DELETE FROM ClassStudents WHERE (ClassID = @classID) AND (UserID = @userID)"
            InsertCommand="INSERT INTO ClassStudents(UserID, ClassID) VALUES (@userID, @classID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="classesGridView" Name="classID" PropertyName="SelectedValue" />
            </SelectParameters>
            <DeleteParameters>
                <asp:ControlParameter ControlID="classesGridView" Name="classID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="classListView" DefaultValue="1" Name="userID" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userID" />
                <asp:ControlParameter ControlID="classesGridView" Name="classID" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <div class="gridheader">
            <asp:Button ID="btnLogoff" runat="server" OnClick="btnLogoff_Click" Text="Logoff" />
        </div>
    </form>
</body>
</html>

