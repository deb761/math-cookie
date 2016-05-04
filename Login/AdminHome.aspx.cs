using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ShowUserDetails(object sender, GridViewCommandEventArgs e)
    {
        string currentCommand = e.CommandName;
        int currentRowIndex = Int32.Parse(e.CommandArgument.ToString());
        int UserID = (int)(sender as GridView).DataKeys[currentRowIndex].Value;
    }

}