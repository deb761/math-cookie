<%@ Application Language="C#" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
      
    }

    void Application_End(object sender, EventArgs e) 
    {
        
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        
    }

    void Session_Start(object sender, EventArgs e)
    {
        
    }

    void Session_End(object sender, EventArgs e) 
    {
        Session["userName"] = String.Empty;
        Session["password"] = String.Empty;
    }
         
</script>
