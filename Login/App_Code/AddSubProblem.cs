// Liz Fallin
// BIT 286 Project
// Spring Quarter 2016

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;

namespace Solstice.Models
{
    public enum ProblemType { Addition, Subtraction, PlaceValue }

    public class AddSubProblem
    {
        public int AddSubProblemID { get; set; }
        public int Level { get; set; }
        public int Operator1 { get; set; }
        public int Operator2 { get; set; }
        public int Result { get; set; }
        public ProblemType ProblemType { get; set; }

        public AddSubProblem(int id)
        {
            AddSubProblemID = id;
        }

        public AddSubProblem(int id, int level, int operator1, int operator2, int result, ProblemType probType)
        {
            this.AddSubProblemID = id;
            this.Level = level;
            this.Operator1 = operator1;
            this.Operator2 = operator2;
            this.Result = result;
            this.ProblemType = probType;
        }

        //    // Get a single problem based on the problemid
        //    public AddSubProblem(int id)
        //    {
        //        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SolsticeAPI_dbConnectionString"].ConnectionString);
        //        conn.Open();
        //        string sql = @" SELECT AddSubProblemID, Level, Operator1, Operator2, Result, ProblemType FROM AddSubProblems where AddSubProblemID = @id";

        //        using (SqlCommand comm = new SqlCommand(sql, conn))
        //        {
        //            // Insert id into string
        //            comm.Parameters.AddWithValue("@id", id.ToString());

        //            using (var reader = comm.ExecuteReader())
        //            {
        //                if (!reader.Read())
        //                    throw new Exception("Error retrieving problem ID " + id.ToString());

        //                AddSubProblemID = reader.GetOrdinal("AddSubProblemID");
        //                Level = reader.GetOrdinal("Level");
        //                Operator1 = reader.GetOrdinal("Operator1");
        //                Operator2 = reader.GetOrdinal("Operator2");
        //                Result = reader.GetOrdinal("Result");
        //                ProblemType = (ProblemType)reader.GetOrdinal("ProblemType");
        //            }
        //        }
        //    }
        //
    }
}
