using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class Welcome : System.Web.UI.Page
{
    DataSet soup;

    void Page_Load()
    {
        string xmlFilename = Server.MapPath("~/App_Data/visitor.xml");
        XDocument doc;
        doc = XDocument.Load(xmlFilename);
        soup = new DataSet();
        soup.ReadXml(xmlFilename);
        ian.DataSource = soup;
        ian.DataBind();

        // Assign value to Label from the Session data
        lblVisitorName.Text = (String)Session["userName"] + "!";
        lblVisitorName.Visible = true;
        // Display the current date and time
        lblCurrentDateTime.Text = Convert.ToString(System.DateTime.Now);
    }

    // Read the visitor.xml file
    private DataSet ReadXMLDataSet()
    {
        DataSet myFile = new DataSet();
        string xmlFilename = Server.MapPath("~/App_Data/visitor.xml");
        myFile.ReadXml(xmlFilename);
        return myFile;
    }

    // Save the new XML LOG FILE with datetime in file name and display message
    private void SaveXMLDataSet(DataSet dset)
    {
        string today = DateTime.Now.ToString("MMddyyyy_hhmmss"); // Gets datetime to string
        string filename = "visitorlog_" + today + ".xml"; // Injects string into file name
        string filepath = "App_Data/" + filename; // Places new file in App_Data folder
        string xmlFilename = Server.MapPath(filepath);
        if (dset != null)
        {
            dset.WriteXml(xmlFilename);
        }
        lbXmlFile.Text = filename + " has been created successfully in App_Data folder.";
        lbXmlFile.Visible = true;
    }

    // Button to save the XML LOG FILE
    protected void btnSave_Click2(object sender, EventArgs e)
    {
        DataTable dt = HttpContext.Current.Application["visitorTable"] as DataTable;
        DataSet myDset = ReadXMLDataSet();
        if (myDset != null & myDset.Tables.Count > 0)
        {
            // Copy the structure of row and fill data
            foreach (DataRow row in dt.Rows)
            {
                DataRow myDrow = myDset.Tables[0].NewRow();

                myDrow["session_id"] = row["session_id"].ToString();
                myDrow["username"] = row["username"].ToString();
                myDrow["login_time"] = row["login_time"].ToString();
                myDrow["ip_address"] = row["ip_address"].ToString();
                myDset.Tables[0].Rows.Add(myDrow);  //add row to datatable          
            }
            myDset.AcceptChanges(); //commit changes      
            //save the changes
            SaveXMLDataSet(myDset);
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        DataTable dt = HttpContext.Current.Application["visitorTable"] as DataTable;
        string sess = Session.SessionID.ToString(); //primary key to be deleted
        DataRow foundRow = dt.Rows.Find(sess); // find the row of that session
        int rowToBeDeleted = dt.Rows.IndexOf(foundRow); //get the row index
        dt.Rows[rowToBeDeleted].Delete(); //delete row from data table
        Application["visitorTable"] = dt; //put it back to application variable
        Session.Abandon(); // remove session variable
        Response.Redirect("Logout.aspx"); // go to Logout page
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

}