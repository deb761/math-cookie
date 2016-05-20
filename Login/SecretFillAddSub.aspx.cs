using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Solstice;

public partial class SecretFillAddSub : ProtectedPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Redirect(UserType.Super))
            return;

        const int MaxLev1 = 10;
        //const int MaxLev2 = 100;
        try
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SolsticeAPI_dbConnectionString"].ConnectionString);
            conn.Open();
            string checkuser = "SELECT * FROM AddSubProblems";
            SqlCommand com = new SqlCommand(checkuser, conn);
            SqlDataReader reader = com.ExecuteReader();

            if (!reader.HasRows) // table is empty
            {
                conn.Close();
                // Reopen the connection to add records
                conn.Open();
                // Add level 1 problems
                int level = 1;
                for (int op1 = 0; op1 < MaxLev1; op1++)
                {
                    for (int op2 = 0; op2 < MaxLev1; op2++)
                    {
                        int sum = op1 + op2;
                        if (sum < MaxLev1)
                        {
                            AddRecord(conn, level, op1, op2, sum, ProblemType.Addition);

                        }
                    }
                }
                // subtraction
                for (int op1 = 0; op1 < MaxLev1; op1++)
                {
                    for (int op2 = 0; op2 <= op1; op2++)
                    {
                        int result = op1 - op2;
                        AddRecord(conn, level, op1, op2, result, ProblemType.Subtraction);
                    }
                }
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            lblCreateError.Visible = true;
            lblCreateError.Text = "Error: " + ex.ToString();
        }
    }
    private void AddRecord(SqlConnection conn, int level, int op1, int op2, int result, ProblemType prob)
    {
        string query = "INSERT INTO AddSubProblems (Level, Operator1, Operator2, Result, ProblemType) " +
            "VALUES (@level, @operator1, @operator2, @result, @problemType)";
        SqlCommand com1 = new SqlCommand(cmdText: query, connection: conn);
        com1.Parameters.Add(new SqlParameter("@level", level));
        com1.Parameters.Add(new SqlParameter("@operator1", op1));
        com1.Parameters.Add(new SqlParameter("@operator2", op2));
        com1.Parameters.Add(new SqlParameter("@result", result));
        com1.Parameters.Add(new SqlParameter("@problemType", (int)prob));
        com1.ExecuteNonQuery(); // Used for Insert, Update, Delete SQL Statements
    }
}