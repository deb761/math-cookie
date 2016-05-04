<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SecretFillAddSub.aspx.cs" Inherits="SecretFillAddSub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<asp:gridview runat="server" AutoGenerateColumns="False" DataKeyNames="AddSubProblemID" DataSourceID="AddSubDataSource">
    <Columns>
        <asp:BoundField DataField="AddSubProblemID" HeaderText="AddSubProblemID" InsertVisible="False" ReadOnly="True" SortExpression="AddSubProblemID" />
        <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" />
        <asp:BoundField DataField="Operator1" HeaderText="Operator1" SortExpression="Operator1" />
        <asp:BoundField DataField="Operator2" HeaderText="Operator2" SortExpression="Operator2" />
        <asp:BoundField DataField="Result" HeaderText="Result" SortExpression="Result" />
        <asp:BoundField DataField="ProblemType" HeaderText="ProblemType" SortExpression="ProblemType" />
    </Columns>
        </asp:gridview>    
        <asp:SqlDataSource ID="AddSubDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SolsticeAPI_dbConnectionString %>" SelectCommand="SELECT * FROM [AddSubProblems]"></asp:SqlDataSource>
    </div>
        <asp:Label ID="lblCreateError" runat="server" ForeColor="Red" Text="Label"></asp:Label>
    </form>
</body>
</html>
