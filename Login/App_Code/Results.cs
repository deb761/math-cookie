using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

public enum ProblemType { Addition, Subtraction, PlaceValue }
/// <summary>
/// Summary description for Results
/// </summary>
public static class Results
{
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
}