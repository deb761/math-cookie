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
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ResultDataSource" DataTextField="ClassName" DataValueField="ClassID" Font-Size="Large">
        </asp:DropDownList>
        </h2>
        <asp:GridView ID="classOverview" runat="server" DataSourceID="SqlDataSource1" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="UserID"
            OnSelectedIndexChanged="classOverview_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="Level" HeaderText="Level" ReadOnly="True" SortExpression="Level" />
                <asp:BoundField DataField="Missed" HeaderText="Missed" ReadOnly="True" SortExpression="Missed">
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:CommandField ShowSelectButton="True" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="GetClassSummary" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" DefaultValue="1" Name="classID" PropertyName="SelectedValue" Type="Int32" />
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
