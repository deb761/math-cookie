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
    /// <returns>A result element with level, round, and count of problems to quiz
    /// for the current round</returns>
    public GetLastRoundResult GetCurrentRound(int studentID)
    {
        GetLastRoundResult roundTable = null;
        var result = GetLastRound(studentID);
        foreach (GetLastRoundResult round in result)
        {
            roundTable = round;
            LevelRules rules = Rules.Levels[round.Level];
            // The rounds for a table are in a 0-indexed array, the
            // tracking of rounds is 1-indexed, so subtrack one
            if (roundTable.Count >= rules.Rounds[round.Round - 1].NumProblems)
            {
                if (roundTable.Round >= rules.Rounds.Length)
                {
                    roundTable.Level++;
                    roundTable.Round = 1;
                }
                else
                {
                    roundTable.Round++;
                }
                roundTable.Count = rules.Rounds[roundTable.Round - 1].NumProblems;
            }
        }
        if (roundTable == null) // no results found for this student
        {
            roundTable = new GetLastRoundResult();
            roundTable.Level = 1;
            roundTable.Round = 1;
            roundTable.Count = Rules.Levels[1].Rounds[0].NumProblems;
        }

        return roundTable;
    }
}