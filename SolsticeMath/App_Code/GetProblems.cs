using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Additional methods for DataClassesDataContext, which is auto-generated using
/// LINQ to SQL
/// </summary>
public partial class DataClassesDataContext : System.Data.Linq.DataContext
{
    /// <summary>
    /// Retrieve the AddSubProblems that match the IDs
    /// </summary>
    /// <param name="ids">list of AddSubProblem IDs</param>
    public IEnumerable<AddSubProblem> GetProblems(List<int> ids)
    {
        DataTable idsTable = new DataTable();
        idsTable.Columns.Add("ID", typeof(int));

        foreach (int id in ids)
            idsTable.Rows.Add(id);

        using (SqlConnection conn = new SqlConnection(Connection.ConnectionString))
        {
            SqlCommand cmd = new SqlCommand("GetProblems", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter p = cmd.Parameters.AddWithValue("@probids", idsTable);
            p.SqlDbType = SqlDbType.Structured;
            p.TypeName = "integer_list_tbltype";

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            // Naturally, you already retrieved your objects so no deferred
            // loading needed nor possible, hence the ToList()
            return this.Translate<AddSubProblem>(reader).ToList();
        }
    }
    /// <summary>
    /// Find out what level and round a student should start at when starting a game.
    /// </summary>
    /// <param name="studentID"></param>
    /// <returns>A result element with level, round number, and round rules of problems to quiz
    /// for the current round</returns>
    public CurrentRound GetCurrentRound(int studentID)
    {
        CurrentRound currLesson = null;
        var result = GetLastRound(studentID);
        foreach (GetLastRoundResult roundResult in result)
        {
            currLesson = new CurrentRound(roundResult);
        }
        if (currLesson == null) // no results found for this student
        {
            currLesson = new CurrentRound();
        }

        return currLesson;
    }
}
/// <summary>
/// Put the data related to a students current lesson in a class
/// </summary>
public class CurrentRound
{
    /// <summary>
    /// Level the student is on
    /// </summary>
    public int Level { get; set; }
    /// <summary>
    /// Lesson within the level the student is on
    /// </summary>
    public int RoundNum { get; set; }
    /// <summary>
    /// Round rules for the current round
    /// </summary>
    public Round Round { get; set; }
    /// <summary>
    /// True when the student has finished all levels
    /// </summary>
    public bool Complete { get; set; }
    /// <summary>
    /// Default Constructor, sets values to 0 and null
    /// </summary>
    public CurrentRound()
    {
        Level = 1;
        RoundNum = 1;
        Round = Rules.Levels[Level].Rounds[0];
        Complete = false;
    }
    /// <summary>
    /// Initialize current lesson using values from GetLastRoundResult
    /// </summary>
    /// <param name="roundResult">Results of last round the student worked</param>
    public CurrentRound(GetLastRoundResult roundResult)
    {
        Level = roundResult.Level;
        RoundNum = roundResult.Round;
        LevelRules rules = Rules.Levels[Level];
        // If the student has for some reason completed more rounds
        // than exist for the level, increment the level
        if (RoundNum > rules.Rounds.Length)
        {
            NextRound();
            return;
        }
        // See if the student has completed a round
        else
        {
            Round = rules.Rounds[roundResult.Round - 1];
            if (roundResult.Count >= Round.NumProblems)
            {
                NextRound();
            }
            else
            {
                Round = rules.Rounds[RoundNum - 1];
            }
        }
    }
    /// <summary>
    /// Increment the Current Round to the next, incrementing the level if
    /// the student has finished it, and marking the student as complete if
    /// all levels are complete
    /// </summary>
    public void NextRound()
    {
        LevelRules rules = Rules.Levels[Level];
        // If the student has for some reason completed more rounds
        // than exist for the level, increment the level
        if (RoundNum >= rules.Rounds.Length)
        {
            // We expect that the highest level number will match the count of levels
            if (Level >= Rules.Levels.Count)
            {
                Complete = true;
                return;
            }

            Level++;
            RoundNum = 1;
            Round = Rules.Levels[Level].Rounds[0];
        }
        else
        {
            RoundNum++;
        }
        Round = rules.Rounds[RoundNum - 1];
    }
}