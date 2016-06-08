using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Solstice
{
    public partial class ClassView : ProtectedPage
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
            {
                return;
            }
        }
        /// <summary>
        /// Currently selected class
        /// </summary>
        Class curClass;
        /// <summary>
        /// Update the label over the class details grid when the class is selected
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void classesGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                curClass = db.Classes.Where(x => x.ClassID == (int)(sender as GridView).SelectedValue).First();
            }
            lblClass.Text = String.Format("Details for {0}", curClass.ClassName);
        }
        /// <summary>
        /// Add a student to the currently selected class
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAddStudent_Click(object sender, EventArgs e)
        {
/*            using (DataClassesDataContext dc = new DataClassesDataContext())
            {
                // Get the controls that contain the updated values. Because they are in a TemplateField 
                // they are not defined as fields, so we need to FindControl.
                DropDownList ddlStudent = (DropDownList)classStudentsListView.FooterRow.FindControl("ddlStudent");

                ClassStudent cs = new ClassStudent();
                cs.ClassID = (int)(classesGridView.SelectedValue);
                cs.UserID = int.Parse(ddlStudent.SelectedValue);
                dc.ClassStudents.InsertOnSubmit(cs);
                // There is a possibility that the record will be invalid,
                // so add a try-catch block here
                try
                {
                    dc.SubmitChanges();
                    classStudentsGridView.DataBind();
                }
                catch { }
            }*/
        }
        /// <summary>
        /// Add a new class to the table when the user selects Add
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAddClass_Click(object sender, EventArgs e)
        {
            using (DataClassesDataContext dc = new DataClassesDataContext())
            {
                Class cls = new Class();
                // Get the controls that contain the updated values. Because they are in a TemplateField 
                // they are not defined as fields, so we need to FindControl.
                GridViewRow footerRow = classesGridView.FooterRow;
                DropDownList ddlYear = (DropDownList)footerRow.FindControl("ddlYear");
                DropDownList ddlRoom = (DropDownList)footerRow.FindControl("ddlYear");
                TextBox txtName = (TextBox)footerRow.FindControl("txtClassName");
                DropDownList ddlTeacher = (DropDownList)footerRow.FindControl("ddlTeacher");

                cls.ClassName = txtName.Text;
                cls.TeacherID = int.Parse(ddlTeacher.SelectedValue);
                cls.RoomID = int.Parse(ddlRoom.SelectedValue);
                cls.YearID = int.Parse(ddlYear.SelectedValue);
                dc.Classes.InsertOnSubmit(cls);
                // There is a possibility that the record will be invalid,
                // so add a try-catch block here
                try
                {
                    dc.SubmitChanges();
                    classesGridView.DataBind();
                }
                catch { }
            }
        }
        /// <summary>
        /// Set the values for the insert command.
        /// </summary>
        /// <param name="sender">ListView Control doing the updating</param>
        /// <param name="e">Event arguements</param>
        protected void classListView_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            e.Values["UserID"] = int.Parse(((DropDownList)e.Item.FindControl(id: "ddlStudent")).SelectedValue);
            e.Values["ClassID"] = classesGridView.SelectedValue;
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
