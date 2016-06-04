//using CryptSharp;
using System;
using System.Text;
using System.Web.UI.WebControls;

namespace Solstice
{
    public partial class AdminHome : ProtectedPage
    {
        /// <summary>
        /// Make sure a user is logged in and that he/she has
        /// permission to be on this page
        /// </summary>
        /// <param name="sender">not used</param>
        /// <param name="e">not used</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Redirect(UserTypeEnum.Administrator))
                return;
        }
        /// <summary>
        /// Update the user displayed in the user details area
        /// </summary>
        /// <param name="sender">not used</param>
        /// <param name="e">not used</param>
        protected void ShowUserDetails(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int currentRowIndex = Int32.Parse(e.CommandArgument.ToString());
                int UserID = (int)(sender as GridView).DataKeys[currentRowIndex].Value;
            }
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
        /// <param name="e">update arguments</param>
        protected void userDetailView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (IsValid)
            {
                TextBox boxPassword = userDetailView.FindControl("boxPassword") as TextBox;
                //Hash user password              
                e.NewValues["Password"] = Security.HashPassword(boxPassword.Text);
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
                e.Values["Password"] = Security.HashPassword(boxPassword.Text);
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
        /// <summary>
        /// Take the user to the logout page
        /// </summary>
        /// <param name="sender">not used</param>
        /// <param name="e">not used</param>
        protected void btnLogoff_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}