<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherHome.aspx.cs" Inherits="Solstice.TeacherHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Teacher</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Class Overview</h1>
        <h2><asp:Label ID="Label1" runat="server" Text="Class"></asp:Label>
        <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="ResultDataSource" DataTextField="ClassName" DataValueField="ClassID" Font-Size="Large">
        </asp:DropDownList>
        </h2>
        <asp:GridView ID="classOverview" runat="server" DataSourceID="OverviewDataSource" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="UserID"
            showfooter="True" 
            OnSelectedIndexChanged="classOverview_SelectedIndexChanged" OnRowDataBound="classOverview_RowDataBound" OnRowUpdating="classOverview_RowUpdating">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" InsertVisible="False" ReadOnly="True" Visible="False" />
                <asp:TemplateField HeaderText="Login" SortExpression="Login">
                    <EditItemTemplate>
                        <asp:Label ID="lblLogin" runat="server" Text='<%# Bind("Login") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Login") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <EditItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text="Password" ForeColor="White"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="White"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                    </ItemTemplate>
                    <footertemplate>
                        <asp:DropDownList ID="ddlStudent" runat="server" DataSourceID="UserDataSource" DataTextField="Name" DataValueField="UserID" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged">
                            <asp:ListItem Text="---Select---" Value="0" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT Users.UserID, Users.FirstName + ' ' + Users.LastName AS Name FROM Users INNER JOIN ClassStudents ON Users.UserID = ClassStudents.UserID WHERE (ClassStudents.ClassID &lt;&gt; @classID) ORDER BY Name">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlClass" Name="classID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Student is required" ControlToValidate="ddlStudent" InitialValue="---Select---"></asp:RequiredFieldValidator>
                    </footertemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" ReadOnly="True" />
                <asp:TemplateField HeaderText="Missed" SortExpression="Missed">
                    <EditItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text="Confirm" ForeColor="White"></asp:Label>
                        <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirm" ErrorMessage="Confirm Password" ForeColor="White"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtPassword" ErrorMessage="Passwords must match" ForeColor="White"></asp:CompareValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Missed") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField HeaderText="Select" ShowHeader="True" ShowSelectButton="True" />
                <asp:CommandField EditText="Set Pass" ShowEditButton="True" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="deletebtn" runat="server" CommandName="Delete"
                            Text="Delete" OnClientClick="return confirm('Are you sure?');" />
                    </ItemTemplate>
                    <footertemplate>
                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="New" Text="Add" OnClick="btnAdd_Click"></asp:LinkButton>
                    </footertemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="OverviewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
            SelectCommand="GetClassSummary" SelectCommandType="StoredProcedure"
            DeleteCommand="DELETE FROM ClassStudents WHERE (ClassID = @classID) AND (UserID = @userID)"
            InsertCommand="INSERT INTO ClassStudents(UserID, ClassID) VALUES (@userID, @classID)"
            UpdateCommand="UPDATE Users SET Password=@password WHERE UserID = @userID">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlClass" DefaultValue="1" Name="classID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="classOverview" DefaultValue="1" Name="userID" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userID" />
                <asp:ControlParameter ControlID="ddlClass" DefaultValue="1" Name="classID" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlClass" DefaultValue="1" Name="classID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="userID" />
                <asp:Parameter Name="password" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="ResultDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="GetTeacherClasses" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="1" Name="teachID" SessionField="UserID" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="yearID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h2><asp:Label ID="lblDetails" runat="server" Text="No Student Selected"></asp:Label></h2>
        <asp:GridView ID="detailsView" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="DetailDataSource">
            <Columns>
                <asp:BoundField DataField="Current_Level" HeaderText="Current Level" SortExpression="Current_Level" />
                <asp:BoundField DataField="Problem" HeaderText="Problem" ReadOnly="True" SortExpression="Problem" />
                <asp:BoundField DataField="Times_Correct" HeaderText="Times Correct" ReadOnly="True" SortExpression="Times_Correct" />
                <asp:BoundField DataField="Answers" HeaderText="Wrong Answers" ReadOnly="True" SortExpression="Answers" />
                <asp:BoundField DataField="Correct_Answer" HeaderText="Correct Answer" SortExpression="Correct_Answer" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="DetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
            SelectCommand="SELECT [Current Level] AS Current_Level, [Problem], [Times Correct] AS Times_Correct, [Answers], [Correct Answer] AS Correct_Answer FROM [MissedProblemDetails] WHERE ([StudentID] = @StudentID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="classOverview" Name="StudentID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="btnLogoff" runat="server" OnClick="btnLogoff_Click" Text="Logoff" />
    </div>
    </form>
</body>
</html>
