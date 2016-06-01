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
        <h2><asp:Label ID="Label1" runat="server" Text="Class"></asp:Label>
        <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="ResultDataSource" DataTextField="ClassName" DataValueField="ClassID" Font-Size="Large">
        </asp:DropDownList>
        </h2>
        <asp:GridView ID="classOverview" runat="server" DataSourceID="OverviewDataSource" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="UserID"
            showfooter="True" 
            OnSelectedIndexChanged="classOverview_SelectedIndexChanged" OnRowDataBound="classOverview_RowDataBound" OnRowDeleting="classOverview_RowDeleting">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" InsertVisible="False" ReadOnly="True" Visible="False" />
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                    </ItemTemplate>
                    <footertemplate>
                        <asp:DropDownList ID="ddlStudent" runat="server" DataSourceID="UserDataSource" DataTextField="Name" DataValueField="UserID" OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
                            SelectCommand="SELECT Users.UserID, Users.FirstName + ' ' + Users.LastName AS Name FROM Users INNER JOIN ClassStudents ON Users.UserID = ClassStudents.UserID WHERE (ClassStudents.ClassID &lt;&gt; @classID) ORDER BY Name">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlClass" Name="classID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </footertemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Level" HeaderText="Level" ReadOnly="True" SortExpression="Level">
                </asp:BoundField>
                <asp:BoundField DataField="Missed" HeaderText="Missed" ReadOnly="True" SortExpression="Missed" />
                <asp:CommandField HeaderText="Select" ShowHeader="True" ShowSelectButton="True" />
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
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="OverviewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>"
            SelectCommand="GetClassSummary" SelectCommandType="StoredProcedure"
            DeleteCommand="DELETE FROM ClassStudents WHERE (ClassID = @classID) AND (UserID = @userID)"
            InsertCommand="INSERT INTO ClassStudents(UserID, ClassID) VALUES (@userID, @classID)">
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
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="ResultDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="GetTeacherClasses" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="1" Name="teachID" SessionField="UserID" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="yearID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h2><asp:Label ID="lblDetails" runat="server" Text="No Student Selected"></asp:Label></h2>
        <asp:GridView ID="detailsView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="DetailDataSource" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Current_Level" HeaderText="Current Level" SortExpression="Current_Level" />
                <asp:BoundField DataField="Problem" HeaderText="Problem" ReadOnly="True" SortExpression="Problem" />
                <asp:BoundField DataField="Times_Correct" HeaderText="Times Correct" ReadOnly="True" SortExpression="Times_Correct" />
                <asp:BoundField DataField="Answers" HeaderText="Wrong Answers" ReadOnly="True" SortExpression="Answers" />
                <asp:BoundField DataField="Correct_Answer" HeaderText="Correct Answer" SortExpression="Correct_Answer" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
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
