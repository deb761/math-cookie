using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Solstice
{
    public partial class GameScreen : ProtectedPage
    {
        private ProblemSet probSet;
        private StudentProblem curProb;
        private int curAnswer, curRound;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Redirect(UserType.Student))
                return;

            if (!IsPostBack)
            {
                int studentID = (int)Session["UserID"];
                probSet = new ProblemSet(studentID, 1, ProblemType.Addition);
                lblProbIdx.Text = "0";
                curProb = probSet.ProblemList[0];
                curRound = 1;
                setUI();
                Session["probSet"] = probSet;
            }
            else
            {
                probSet = (ProblemSet)Session["probSet"];
            }
        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            // get index value from hidden label
            int idx = 0;
            Int32.TryParse(lblProbIdx.Text, out idx);

            curProb = probSet.ProblemList[idx];

            // get student answer from textbox
            int studentAnswer;
            Int32.TryParse(txtStudentInput.Text, out studentAnswer);

            if (studentAnswer == curAnswer)
            {
                // add happy cookie image
                // imgCookie.ImageUrl = "happyCookie.png";
                imgCookie.AlternateText = "Happy Cookie";
            }
            else
            {
                // add sad cookie image
                // imgCookie.ImageUrl = "sadCookie.png";
                imgCookie.AlternateText = "Sad Cookie";
            }

            Result result = new Result();
            result.ResultID = 0;
            result.StudentID = (int)Session["UserID"];
            result.ProblemID = curProb.Problem.AddSubProblemID;
            result.Answer = studentAnswer;
            result.Level = curProb.Problem.Level;
            result.Round = curRound;

            curProb.studentResult = result;

            // check if we've reached the end of the list
            if (idx == probSet.ProblemList.Count)
            {
                probSet.SaveResults();
            }
            else
            {
                // store current index in hidden label
                lblProbIdx.Text = idx.ToString();
            }

            pnlResults.Visible = true;
            setUI();
        }

        private void setUI()
        {
            AddSubProblem prob = curProb.Problem;
            curAnswer = prob.Result;
            string ord1 = prob.Operator1.ToString();
            string ord2 = prob.Operator2.ToString();

            imgOpSign.AlternateText = "+";
            imgOrd1.AlternateText = ord1;
            imgOrd2.AlternateText = ord2;
        }

        protected void btnReady_Click(object sender, ImageClickEventArgs e)
        {
            pnlWelcome.Visible = false;
        }

        protected void btnContinue_Click(object sender, ImageClickEventArgs e)
        {
            pnlResults.Visible = false;
        }

        protected void btnLogoff_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Server.Transfer("Login.aspx");
        }
    }
}