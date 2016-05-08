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


    protected void userGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["UserID"] = (sender as GridView).SelectedValue;
    }

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

    protected void userDetailView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        UpdateGrids();
    }

    private void UpdateGrids()
    {
        teacherGridView.DataBind();
        studentGridView.DataBind();
        adminGridView.DataBind();
    }

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

    protected void userDetailView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        UpdateGrids();
    }
}