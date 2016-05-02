﻿using CryptSharp;
using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Text;

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

    private SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SolsticeAPI_dbConnectionString"].ConnectionString);
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        int userID = GetUserID();
        if (userID != 0)
        {
            //Click on the login to add the user
            DataTable dt = (DataTable)Application["visitorTable"];
            dt.Rows.Add(new object[] { (string)Session["sessionID"], (string)Session["userName"], (System.DateTime)Session["logInTime"], (string)Session["ipAddress"] });
            DataTable dtCopy = dt.Copy();
            DataSet ds = new DataSet();

            ds.Tables.Add(dtCopy);
            string xmlFilename = Server.MapPath("~/App_Data/visitor.xml");
            ds.WriteXml(xmlFilename);
            Server.Transfer("Welcome.aspx");
        }
        else
        {
            loginErrorLabel.Visible = true;
            loginErrorLabel.Text.Insert(loginErrorLabel.Text.Length, "Please try logging in again");
        }

    }
    /// <summary>
    /// Length of the hash string from Blowfish encryption
    /// </summary>
    public const int HashLength = 60;
    /// <summary>
    /// Check to see if the user is in the database and the passwords match.
    /// Notify the user if the username or password are invalid.
    /// </summary>
    /// <returns>userID if username and password are valid, 0 otherwise</returns>
    private int GetUserID()
    {
        lblVldPassword.Visible = false;

        conn.Open();
        string checkuser = "SELECT UserID, Password FROM Users WHERE Login=@username";
        SqlCommand com = new SqlCommand(checkuser, conn);
        com.Parameters.AddWithValue("@username", txtUserName.Text);
        SqlDataReader reader = com.ExecuteReader();
        int userID = 0;

        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string mash = (string)reader.GetValue(1);
                string hash = mash.Substring(startIndex: 0, length: HashLength);
                string salt = mash.Substring(startIndex: HashLength);
                string crypted = Crypter.Blowfish.Crypt(key: Encoding.ASCII.GetBytes(txtPassword.Text),
                    salt: salt);
                if (hash == crypted)
                    userID = (int)reader.GetValue(0);
            }
            if (userID == 0)
                lblVldPassword.Visible = true;
        }
        else
        {
            lblVldPassword.Visible = true;
        }
        conn.Close();
        return userID;
    }
}