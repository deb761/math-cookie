using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtUserName.Text = (string)Session["userName"];

        if (IsPostBack)
        {
            Validate();
        }      
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Validate();
        if (IsValid)
        {
            //Click on the login to add the user
            DataTable dt = (DataTable)Application["visitorTable"];
            dt.Rows.Add(new object[] { (string)Session["sessionID"], (string)Session["userName"], (System.DateTime)Session["logInTime"], (string)Session["ipAddress"] });
            DataTable dtCopy = dt.Copy();
            DataSet ds = new DataSet();

            ds.Tables.Add(dtCopy);
            string xmlFilename = Server.MapPath("~/App_Data/visitor.xml");
            ds.WriteXml(xmlFilename);
            
        }
        

    }
}