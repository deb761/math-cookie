<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDetails.aspx.cs" Inherits="UserDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView runat="server" Height="50px" Width="125px" AutoGenerateRows="False"
                DataKeyNames="UserID" DataSourceID="SolsticeDataSource"
                ID="userDetailView" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
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
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="true" ShowEditButton="true" ShowInsertButton="true" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>
            <h1>Form View</h1>
            <asp:FormView ID="FormView1" runat="server" CellPadding="4"
                DataKeyNames="UserID" DataSourceID="SolsticeDataSource" ForeColor="#333333">
                <EditItemTemplate>
                    UserID:
                    <asp:Label ID="UserIDLabel1" runat="server" Text='<%# Eval("UserID") %>' />
                    <br />
                    UserType:
                    <asp:TextBox ID="UserTypeTextBox" runat="server"
                        Text='<%# Bind("UserType") %>' />
                    <br />
                    Login:
                    <asp:TextBox ID="LoginTextBox" runat="server" Text='<%# Bind("Login") %>' />
                    <br />
                    FirstName:
                    <asp:TextBox ID="FirstNameTextBox" runat="server"
                        Text='<%# Bind("FirstName") %>' />
                    <br />
                    LastName:
                    <asp:TextBox ID="LastNameTextBox" runat="server"
                        Text='<%# Bind("LastName") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True"
                        CommandName="Update" Text="Update" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server"
                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    UserType:
                    <asp:TextBox ID="UserTypeTextBox" runat="server"
                        Text='<%# Bind("UserType") %>' />
                    <asp:RequiredFieldValidator ID="userTypeReqVal" runat="server" ErrorMessage="User Type is required"
                        ControlToValidate="UserTypeTextBox">
                    </asp:RequiredFieldValidator>
                    <br />
                    Login:
                    <asp:TextBox ID="LoginTextBox" runat="server" Text='<%# Bind("Login") %>' />
                    <asp:RequiredFieldValidator ID="loginReqVal" runat="server" ErrorMessage="Login is required"
                        ControlToValidate="UserTypeTextBox">
                    </asp:RequiredFieldValidator>
                    <br />
                    FirstName:
                    <asp:TextBox ID="FirstNameTextBox" runat="server"
                        Text='<%# Bind("FirstName") %>' />
                    <asp:RequiredFieldValidator ID="firstNameReqVal" runat="server" ErrorMessage="First Name is required"
                        ControlToValidate="FirstNameTextBox">
                    </asp:RequiredFieldValidator>
                    <br />
                    LastName:
                    <asp:TextBox ID="LastNameTextBox" runat="server"
                        Text='<%# Bind("LastName") %>' />
                    <asp:RequiredFieldValidator ID="lastNameReqVal" runat="server" ErrorMessage="Last Name is required"
                        ControlToValidate="LastNameTextBox">
                    </asp:RequiredFieldValidator>
                    <br />
                    Password:
                    <asp:TextBox ID="passwordBox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="passwordReqVal" runat="server" ErrorMessage="Password is required"
                        ControlToValidate="passwordBox">
                    </asp:RequiredFieldValidator>
                    <br />
                    Confirm Password:
                    <asp:TextBox ID="confirmPassBox" runat="server"></asp:TextBox>
                    <asp:CompareValidator ID="passwordEqVal" runat="server" ErrorMessage="Passwords must match"
                        ControlToValidate="confirmPassBox" ControlToCompare="passwordBox">
                    </asp:CompareValidator>
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True"
                        CommandName="Insert" Text="Insert" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server"
                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
                    UserID:
                    <asp:Label ID="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>' />
                    <br />
                    UserType:
                    <asp:Label ID="UserTypeLabel" runat="server" Text='<%# Bind("UserType") %>' />
                    <br />
                    Login:
                    <asp:Label ID="LoginLabel" runat="server" Text='<%# Bind("Login") %>' />
                    <br />
                    FirstName:
                    <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                    <br />
                    LastName:
                    <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                    <br />
                </ItemTemplate>
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:FormView>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <asp:SqlDataSource ID="SolsticeDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                SelectCommand="SELECT [UserID], [UserType], [Login], [FirstName], [LastName] FROM [Users]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
