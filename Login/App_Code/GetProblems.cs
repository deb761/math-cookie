using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetProblems
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
}