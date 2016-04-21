<%@ Application Language="C#" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("session_id", System.Type.GetType("System.String")));
        dt.PrimaryKey = new DataColumn[] { dt.Columns["session_id"] };
        dt.Columns.Add(new DataColumn("username", System.Type.GetType("System.String")));
        dt.Columns.Add(new DataColumn("login_time", System.Type.GetType("System.DateTime")));
        dt.Columns.Add(new DataColumn("ip_address", System.Type.GetType("System.String")));
        Application["visitorTable"] = dt;

    }

    void Application_End(object sender, EventArgs e) 
    {
        
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        
    }

    void Session_Start(object sender, EventArgs e)
    {
        Session["sessionID"] = Session.SessionID;
        Session["userName"] = String.Empty;
        Session["logInTime"] = DateTime.Now;
        Session["ipAddress"] = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        Session["password"] = String.Empty;
    }

    void Session_End(object sender, EventArgs e) 
    {
        Session["userName"] = String.Empty;
        Session["password"] = String.Empty;
    }
         
</script>
