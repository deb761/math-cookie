<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GameScreen.aspx.cs" Inherits="Login_GameScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Solstice Math Game</title>
    <style>
        #txtStudentInput {
            margin-bottom: 10%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="pageTitle">
        <h2><asp:Label runat="server" ID="lblScreenTitle" /></h2> 
        <asp:Label runat="server" ID="lblProbIdx" Visible="false" />  
    </div>
    <div id="main">
        <asp:Panel runat="server" ID="pnlWelcome" Visible="true" Height="50%" Width="75%">
            <asp:Label runat="server" ID="lblWelcomeName" /><br />
            <asp:Label runat="server" ID="lblLastTime" /><br />
            <asp:Label runat="server" ID="lblThisTime" /><br />
            <asp:ImageButton runat="server" ID="btnReady" AlternateText="Ready!" OnClick="btnReady_Click" />
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlResults" Visible="false" Height="50%" Width="75%">
            <asp:Label runat="server" ID="lblAnswerResult" /><br />
            <asp:Image runat="server" ID="imgCookie" /><br />
            <asp:ImageButton runat="server" ID="btnContinue" AlternateText="Continue" OnClick="btnContinue_Click" />
        </asp:Panel>
        <span id="expression">
            <asp:Image runat="server" ID="imgOrd1" />
            <asp:Image runat="server" ID="imgOpSign" />
            <asp:Image runat="server" ID="imgOrd2" />
        </span>
        <asp:TextBox runat="server" ID="txtStudentInput" MaxLength="3" Width="75px" Height="50px" BorderColor="Black" BorderWidth="5px" /><br />
        <asp:ImageButton runat="server" ID="btnSubmit" AlternateText="Submit" OnClick="btnSubmit_Click" />
    </div>
    <asp:Button runat="server" ID="btnLogoff" Text="Logoff" OnClick="btnLogoff_Click" />
    </form>
</body>
</html>
