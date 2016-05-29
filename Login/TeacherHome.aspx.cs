using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherHome : ProtectedPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Redirect(UserTypeEnum.Teacher))
            return;
    }
    protected void btnLogoff_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Server.Transfer("Login.aspx");
    }

    User student = null;

    protected void classOverview_SelectedIndexChanged(object sender, EventArgs e)
    {
        using (DataClassesDataContext db = new DataClassesDataContext())
        {
            student = db.Users.Where(x => x.UserID == (int)(sender as GridView).SelectedValue).First();
        }
        lblDetails.Text = String.Format("Student Details for {0} {1}", student.FirstName, student.LastName); 
        detailsView.DataBind();
    }
}