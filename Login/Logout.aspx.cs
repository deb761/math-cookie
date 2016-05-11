using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //to clear out the session and log the user off.
        Session.Clear();
    }

    protected void btnLoginAgain_Click(object sender, EventArgs e)
    {
        //when the button is clicked to log out of the site, and to transfer to new webpage to show that user is logged out. 
        Response.Redirect("Login.aspx");
    }
}