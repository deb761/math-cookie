<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDetails.aspx.cs" Inherits="UserDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Teacher Home</title>
    <style>
        .header { width: 15em; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView runat="server" Height="50px" Width="125px" AutoGenerateRows="False"
                DataKeyNames="UserID" DataSourceID="SolsticeDataSource"
                ID="userDetailView" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" Width="15em" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" Width="30em" Wrap="False" />
                <Fields>
                    <asp:BoundField DataField="UserID" HeaderText="User ID" InsertVisible="False"
                        ReadOnly="True" SortExpression="UserID" HeaderStyle-CssClass="header" >
<HeaderStyle CssClass="header" Width="15em"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="UserType" HeaderText="User Type"
                        SortExpression="UserType" />
                    <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name"
                        SortExpression="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name"
                        SortExpression="LastName" />
                    <asp:TemplateField HeaderText="Password" HeaderStyle-CssClass="pass">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        </InsertItemTemplate>

<HeaderStyle CssClass="pass"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Confirm Password">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Width="15em" />
            </asp:DetailsView>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <asp:SqlDataSource ID="SolsticeDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                SelectCommand="SELECT [UserID], [UserType], [Login], [FirstName], [LastName] FROM [Users]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @original_UserID AND [UserType] = @original_UserType AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))" InsertCommand="INSERT INTO [Users] ([UserType], [Login], [FirstName], [LastName]) VALUES (@UserType, @Login, @FirstName, @LastName)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Users] SET [UserType] = @UserType, [Login] = @Login, [FirstName] = @FirstName, [LastName] = @LastName WHERE [UserID] = @original_UserID AND [UserType] = @original_UserType AND (([Login] = @original_Login) OR ([Login] IS NULL AND @original_Login IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_UserID" Type="Int32" />
                    <asp:Parameter Name="original_UserType" Type="Int32" />
                    <asp:Parameter Name="original_Login" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserType" Type="Int32" />
                    <asp:Parameter Name="Login" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserType" Type="Int32" />
                    <asp:Parameter Name="Login" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="original_UserID" Type="Int32" />
                    <asp:Parameter Name="original_UserType" Type="Int32" />
                    <asp:Parameter Name="original_Login" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
