using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherHome : ProtectedPage
{
    /// <summary>
    /// Redirect if no user or the wrong user type is logged in.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Redirect(UserTypeEnum.Teacher))
            return;
    }
    /// <summary>
    /// End the session and return the user to the login screen.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnLogoff_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Server.Transfer("Login.aspx");
    }
    /// <summary>
    /// Currently selected student
    /// </summary>
    User student = null;
    /// <summary>
    /// Update the header over the student details table
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void classOverview_SelectedIndexChanged(object sender, EventArgs e)
    {
        using (DataClassesDataContext db = new DataClassesDataContext())
        {
            student = db.Users.Where(x => x.UserID == (int)(sender as GridView).SelectedValue).First();
        }
        lblDetails.Text = String.Format("Student Details for {0} {1}", student.FirstName, student.LastName);
    }
}