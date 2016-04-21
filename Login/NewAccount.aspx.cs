using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
        }
        else
            Validate();
    }

   
    protected void btnCreateAcct_Click(object sender, EventArgs e)
    {
       
        //store the last name into the session so that it becomes the username int he generator
        Session["lastName"] = txtLastName.Text;
        
        Validate();
        if (IsValid)
        {
            Server.Transfer("password.aspx");
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtFirstName.Text = "";
        txtLastName.Text = "";
        
    }

}