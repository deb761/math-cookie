using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SolsticeGameScreen
{
	public partial class GameScreen : System.Web.UI.Page
	{
		private ProblemSet probSet;
		private StudentProblem curProb;
		private int curAnswer, curRound;

		protected void Page_Load(object sender, EventArgs e)
		{
			User.UserType uType = (User.UserType)Session["UserType"];

			if (uType == User.UserType.Student)
			{
				if (!IsPostBack)
				{
					int studentID = (int)Session["UserID"];
					probSet = new ProblemSet(studentID, 1, ProblemType.Addition);
					lblProbIdx.Text = "0";
					curProb = probSet.ProblemList.Item[0];
					curRound = 1;
					setUI();
				}
			}
			else if (uType == User.UserType.Teacher)
			{
				Response.Redirect("TeacherHome.aspx");
			}
			else
			{
				Response.Redirect("AdminHome.aspx");
			}
		}

		protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
		{
			// get an increment index value from hidden label
			int idx;
			Int32.TryParse(lblProbIdx.Text, out idx);
			idx++;

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
			result.ProblemID = curProb.AddSubProblemID;
			result.Answer = studentAnswer;
			result.Level = curProb.Level;
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
				curProb = probSet.ProblemList.Item[idx];
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

		}
	}
}