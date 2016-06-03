using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Solstice
{
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

        protected void classOverview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    LinkButton btn = (LinkButton)e.Row..FindControl("LinkButton1");
            //    btn.Attributes.Add("onclick", "javascript:return " +
            //    "confirm('Are you sure you want to delete this record " +
            //    DataBinder.Eval(e.Row.DataItem, "CategoryID") + "')");
            //}
        }

        /// <summary>
        /// Add the student selected in the drop down list to the class.
        /// Obtain the class ID from the Class drop down list and the 
        /// student's user ID from the student drop down list
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (DataClassesDataContext dc = new DataClassesDataContext())
            {
                if (selectedStudentID != 0)
                {
                    ClassStudent cs = new ClassStudent();
                    cs.ClassID = int.Parse(ddlClass.SelectedItem.Value);
                    cs.UserID = selectedStudentID;
                    dc.ClassStudents.InsertOnSubmit(cs);
                    // There is a possibility that the record will be invalid,
                    // so add a try-catch block here
                    try
                    {
                        dc.SubmitChanges();
                        classOverview.DataBind();
                    }
                    catch { }
                }
            }
        }
        /// <summary>
        /// The ID of the student selected in the class details footer dropdown
        /// </summary>
        private int selectedStudentID;
        /// <summary>
        /// Store the selected student ID in a field because the dropdownlist is not
        /// visible from its ID
        /// </summary>
        /// <param name="sender">DropDownList is class details footer</param>
        /// <param name="e">event data, not used</param>
        protected void ddlStudent_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectedStudentID = int.Parse((sender as DropDownList).SelectedItem.Value);
        }
        /// <summary>
        /// Update the students password when the user updates a row
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void classOverview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (!IsValid) return;

            // Get the GridViewRow object that represents the row being edited
            // from the Rows collection of the GridView control.
            GridViewRow row = classOverview.Rows[e.RowIndex];

            // Get the controls that contain the updated values. Because they are in a TemplateField 
            // they are not defined as fields, so we need to FindControl.
            TextBox txtPassword = (TextBox)row.FindControl("txtPassword");
            // Set the new value of the password field to the hash of the password textbox
            e.NewValues["Password"] = Security.HashPassword(txtPassword.Text);
        }
    }
}