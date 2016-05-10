using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

/// <summary>
/// An enumeration that trackt problem type
/// </summary>
public enum ProblemType { Addition, Subtraction, PlaceValue }
/// <summary>
/// An enumeration that tracks user type
/// </summary>
public enum UserType { Student, Teacher, Administrator, Super }
/// <summary>
/// Summary description for Results
/// </summary>
public static class Results
{
    /// <summary>
    /// Save the results of a problem using a SqlConnection
    /// </summary>
    /// <param name="page">Current page</param>
    public static void SaveResults(Page page)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SolsticeAPI_dbConnectionString"].ConnectionString);
        conn.Open();
        string query = "INSERT INTO AddSubProblems (StudentID, ProblemID, Answer, Level, Round) " +
            "VALUES (@student, @problem, @answer, @level, @round)";
        SqlCommand com = new SqlCommand(cmdText: query, connection: conn);
        com.Parameters.Add(new SqlParameter("@student", (int)page.Session["StudentID"]));
        com.Parameters.Add(new SqlParameter("@problem", (int)page.Session["ProblemID"]));
        com.Parameters.Add(new SqlParameter("@answer", (int)page.Session["Answer"]));
        com.Parameters.Add(new SqlParameter("@level", (int)page.Session["Level"]));
        com.Parameters.Add(new SqlParameter("@round", (int)page.Session["Round"]));
        com.ExecuteNonQuery(); // Used for Insert, Update, Delete SQL Statements
        conn.Close();
    }
    /// <summary>
    /// Save the results of a problem using LINQ to SQL and the Session dictionary
    /// </summary>
    /// <param name="page">Current Page</param>
    public static void SaveResultsLinq(Page page)
    {
        using (DataClassesDataContext context = new DataClassesDataContext())
        {
            Result result = new Result();
            result.StudentID = (int)page.Session["StudentID"];
            result.ProblemID = (int)page.Session["ProblemID"];
            result.Answer = (int)page.Session["Answer"];
            result.Level = (int)page.Session["Level"];
            result.Round = (int)page.Session["Round"];

            context.Results.InsertOnSubmit(result);
            context.SubmitChanges();
        }
    }
    /// <summary>
    /// Save the results of a problem using LINQ to SQL and a result record
    /// </summary>
    /// <param name="result">Result object</param>
    public static void SaveResults(Result result)
    {
        using (DataClassesDataContext context = new DataClassesDataContext())
        {
            context.Results.InsertOnSubmit(result);
            context.SubmitChanges();
        }
    }
}