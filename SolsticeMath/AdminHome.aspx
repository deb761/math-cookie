<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminHome.aspx.cs" Inherits="Solstice.AdminHome" %>

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
        <div class="block">
        <h1>Teachers</h1>
        <asp:gridview runat="server" AllowSorting="True" 
            DataSourceID="TeacherDataSource" 
            AutoGenerateColumns="False" ID="teacherGridView" DataKeyNames="UserID" 
            OnRowCommand="ShowUserDetails" AllowPaging="True" OnSelectedIndexChanged="userGridView_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"
                            OnClientClick="return confirm('Are you sure?');"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
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
        </div>
        <div class="block">
            <h1>User Details</h1>
            <asp:DetailsView runat="server" Height="50px" Width="125px" AutoGenerateRows="False"
                DataKeyNames="UserID" DataSourceID="SolsticeDataSource"
                ID="userDetailView" OnItemUpdating="userDetailView_ItemUpdating" OnItemUpdated="userDetailView_ItemUpdated" OnItemInserted="userDetailView_ItemInserted" OnItemInserting="userDetailView_ItemInserting">
                <EditRowStyle Width="15em" />
                <FieldHeaderStyle Width="30em" Wrap="False" />
                <Fields>
                    <asp:BoundField DataField="UserID" HeaderText="User ID" InsertVisible="False"
                        ReadOnly="True" SortExpression="UserID" HeaderStyle-CssClass="header">
                        <HeaderStyle CssClass="gridheader" Width="15em"></HeaderStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="User Type" SortExpression="UserType">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="UserTypeDataSource"
                                DataValueField="UserTypeID" Width="90px" DataTextField="UserTypeName"
                                SelectedValue='<%# Bind("UserType") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="UserTypeDataSource"
                                DataValueField="UserTypeID" Width="90px" DataTextField="UserTypeName"
                                SelectedValue='<%# Bind("UserType") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("UserTypeName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name"
                        SortExpression="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name"
                        SortExpression="LastName" />
                    <asp:TemplateField HeaderText="Password" >
                        <EditItemTemplate>
                            <asp:TextBox ID="boxPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password is required"
                                ControlToValidate="boxPassword">
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords must match" ControlToValidate="boxPassword" ControlToCompare="boxConfirm"></asp:CompareValidator>
                            </asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="boxPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Must confirm Password"
                                ControlToValidate="boxPassword">
                            </asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Passwords must match" ControlToValidate="boxPassword" ControlToCompare="boxConfirm"></asp:CompareValidator>
                        </InsertItemTemplate>

                        <HeaderStyle CssClass="gridheader"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Confirm Password" HeaderStyle-VerticalAlign="Top">
                        <EditItemTemplate>
                            <asp:TextBox ID="boxConfirm" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="You must re-enter the password"
                                ControlToValidate="boxConfirm">
                            </asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="boxConfirm" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="You must re-enter the password"
                                ControlToValidate="boxConfirm">
                            </asp:RequiredFieldValidator>
                        </InsertItemTemplate>

                        <HeaderStyle VerticalAlign="Top"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
                <RowStyle Width="15em" />
            </asp:DetailsView>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <asp:SqlDataSource ID="UserTypeDataSource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                    SelectCommand="SELECT * FROM [UserTypes] ORDER BY [UserTypeID]">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SolsticeDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                SelectCommand="SELECT [Users].*, UserTypeName FROM [Users] JOIN [UserTypes] ON UserTypeID = [Users].UserType WHERE ([UserID] = @UserID)"
                ConflictDetection="CompareAllValues"
                DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @original_UserID AND [UserType] = @original_UserType AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))"
                InsertCommand="INSERT INTO [Users] ([UserType], [Login], [FirstName], [LastName], [Password]) VALUES (@UserType, @Login, @FirstName, @LastName, @Password)"
                OldValuesParameterFormatString="original_{0}"
                UpdateCommand="UPDATE [Users] SET [UserType] = @UserType, [Login] = @Login, [FirstName] = @FirstName, [LastName] = @LastName, [Password] = @Password WHERE [UserID] = @original_UserID">
                <DeleteParameters>
                    <asp:Parameter Name="original_UserID" Type="Int32" />
                    <asp:Parameter Name="original_UserType" Type="Int32" />
                    <asp:Parameter Name="original_Login" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                    <asp:Parameter Name="original_Password" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserType" Type="Int32" />
                    <asp:Parameter Name="Login" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Password" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="1" Name="UserID" SessionField="SelUserID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserType" Type="Int32" />
                    <asp:Parameter Name="Login" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="original_UserID" Type="Int32" />
                    <asp:Parameter Name="original_UserType" Type="Int32" />
                    <asp:Parameter Name="original_Login" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                    <asp:Parameter Name="original_Password" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div class="block">
        <h1>Students</h1>  
        <asp:gridview runat="server" AllowSorting="True" DataSourceID="StudentDataSource" ID="studentGridView"
            AutoGenerateColumns="False" DataKeyNames="UserID" 
            OnRowCommand="ShowUserDetails" AllowPaging="True" CssClass="block" OnSelectedIndexChanged="userGridView_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="btnDelStudent" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure?');" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Link" ShowSelectButton="True" />
            </Columns>
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
        </div>
        <div class="block">
        <h1>Administrators</h1>  
        <asp:gridview runat="server" AllowSorting="True" DataSourceID="AdminDataSource" ID="adminGridView" OnRowCommand="ShowUserDetails"
            AutoGenerateColumns="False" DataKeyNames="UserID" AllowPaging="True" OnSelectedIndexChanged="userGridView_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                    SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" 
                    SortExpression="LastName" />
                <asp:CommandField ButtonType="Link" showeditbutton="true" />
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
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
        <div class="gridheader">
            <asp:Button ID="btnLogoff" runat="server" OnClick="btnLogoff_Click" Text="Logoff" />
        </div>
    </div>
    </form>
</body>
</html>
