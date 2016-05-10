using CryptSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

    /// <summary>
    /// Update the selected user and put in session data
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void userGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SelUserID"] = (sender as GridView).SelectedValue;
    }
    /// <summary>
    /// When the user data is being prepared to send to the server, encrypt the password.
    /// </summary>
    /// <param name="sender">user detail view</param>
    /// <param name="e">update arguements</param>
    protected void userDetailView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        if (IsValid)
        {
            TextBox boxPassword = userDetailView.FindControl("boxPassword") as TextBox;
            //Hash user password
            string salt = Crypter.Blowfish.GenerateSalt(6);
            string crypted = Crypter.Blowfish.Crypt(key: Encoding.ASCII.GetBytes(boxPassword.Text),
                salt: salt);
            e.NewValues["Password"] = crypted;
        }
    }
    /// <summary>
    /// Update the gridviews when a user is updated.
    /// </summary>
    /// <param name="sender">not used</param>
    /// <param name="e">not used</param>
    protected void userDetailView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        UpdateGrids();
    }
    /// <summary>
    /// Update the gridviews when a user is updated.
    /// </summary>
    private void UpdateGrids()
    {
        teacherGridView.DataBind();
        studentGridView.DataBind();
        adminGridView.DataBind();
    }
    /// <summary>
    /// When the user data is being prepared to send to the server, encrypt the password.
    /// </summary>
    /// <param name="sender">user detail view</param>
    /// <param name="e">update arguements</param>
    protected void userDetailView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        if (IsValid)
        {
            TextBox boxPassword = userDetailView.FindControl("boxPassword") as TextBox;
            //Hash user password
            string salt = Crypter.Blowfish.GenerateSalt(6);
            string crypted = Crypter.Blowfish.Crypt(key: Encoding.ASCII.GetBytes(boxPassword.Text),
                salt: salt);
            e.Values["Password"] = crypted;
        }
    }
    /// <summary>
    /// Update the gridviews when a user is inserted.
    /// </summary>
    /// <param name="sender">not used</param>
    /// <param name="e">not used</param>
    protected void userDetailView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        UpdateGrids();
    }

    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("Logout.aspx");
    }
}