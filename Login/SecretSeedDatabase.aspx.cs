using CryptSharp;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SecretSeedDatabase : ProtectedPage
{
    /// <summary>
    /// Redirect all users other than the super user
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Redirect(UserTypeEnum.Super))
            return;
    }
    /// <summary>
    /// The database
    /// </summary>
    DataClassesDataContext db;
    /// <summary>
    /// Create a new database.  If one exists already, destroy it first.
    /// </summary>
    public void CreateDatabase()
    {
        string dbpath = Server.MapPath("App_Data/solstice.mdf");
        db = new DataClassesDataContext(dbpath);
        string connString = db.Connection.ConnectionString;
        if (db.DatabaseExists())
        {
            Console.WriteLine("Deleting old database...");
            //db.Connection.Close();
            db.DeleteDatabase();
        }
        try
        {
            // open a connection to the database 
            db.CreateDatabase();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            db.Connection.Close();
            string SQL = "DROP database [" + "Solstice" + "];";

            SqlConnection conn = new SqlConnection(connString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(SQL, conn);
            cmd.ExecuteNonQuery();
            // try again
            db.CreateDatabase();
        }
    }
    /// <summary>
    /// Seed the new database
    /// </summary>
    private void SeedDatabase()
    {
        AddEnums();
        AddAdminTeachers();
        AddStudents();
        AddClasses();
        AddProblems();
    }
    /// <summary>
    /// Fill the tables that represent enumerations
    /// </summary>
    private void AddEnums()
    {
        for (UserTypeEnum utype = UserTypeEnum.Student; utype <= UserTypeEnum.Super; utype++)
        {
            UserType usert = new UserType();
            usert.UserTypeName = utype.ToString();
            db.UserTypes.InsertOnSubmit(usert);
        }
        for (ProblemTypeEnum ptype = ProblemTypeEnum.Addition; ptype <= ProblemTypeEnum.PlaceValue; ptype++)
        {
            ProblemType probt = new ProblemType();
            probt.ProblemTypeName = ptype.ToString();
            db.ProblemTypes.InsertOnSubmit(probt);
        }
        db.SubmitChanges();
    }
    /// <summary>
    /// Add the administrators and teachers to the database
    /// </summary>
    private void AddAdminTeachers()
    {
        List<User> users = LoadUsers("admins.json");
        List<User> teachers = LoadUsers("teachers.json");
        foreach (User teach in teachers)
        {
            teach.Login = teach.FirstName.ToLower();
            users.Add(teach);
        }
        db.Users.InsertAllOnSubmit(users);
        db.SubmitChanges();
    }
    /// <summary>
    /// Add students that are not already in the database to it
    /// </summary>
    private void AddStudents()
    {
        List<User> students = LoadUsers("students.json");
        List<User> users = new List<global::User>();
        foreach (User kid in students)
        {
            kid.Login = kid.FirstName.ToLower();
            if (db.Users.Where(x => x.Login == kid.Login).Count() == 0)
                users.Add(kid);
        }

        foreach (User user in users)
        {
            string salt = Crypter.Blowfish.GenerateSalt(6);
            string password = user.Login;
            string crypted = Crypter.Blowfish.Crypt(key: Encoding.ASCII.GetBytes(password),
                 salt: salt);
            user.Password = crypted + salt;
        }
        db.Users.InsertAllOnSubmit(users);
        db.SubmitChanges();
    }
    /// <summary>
    /// Load user definitions from a json file
    /// </summary>
    /// <param name="path">path to the file</param>
    /// <returns>List of users</returns>
    private List<User> LoadUsers(string path)
    {
        List<User> users = null;
        using (StreamReader rdr = new StreamReader(Server.MapPath("App_Data/" + path)))
        {
            users = JsonConvert.DeserializeObject<List<User>>(rdr.ReadToEnd());
        }
        return users;
    }
    /// <summary>
    /// Add classes to the database
    /// </summary>
    private void AddClasses()
    {
        // Create a class year
        SchoolYear year = new SchoolYear();
        year.Name = "2015-2016";
        year.Start = DateTime.Parse("9-1-2015");
        year.End = DateTime.Parse("5-30-2016");
        db.SchoolYears.InsertOnSubmit(year);
        db.SubmitChanges();

        // Create a class for each teacher
        // Get the teachers and students with their IDs
        var teachers = db.Users.Where(x => x.UserType == UserTypeEnum.Teacher);
        User[] students = db.Users.Where(x => x.UserType == UserTypeEnum.Student).ToArray();
        int nextStudent = 0;
        int studentsPerClass = students.Length / teachers.Count();

        foreach (User teacher in teachers)
        {
            Class clss = new Class();
            clss.Year = 1; // we know there is only one year ID
            clss.ClassName = string.Format("{0} {1} First Grade", teacher.FirstName, teacher.LastName);
            clss.TeacherID = teacher.UserID;
            db.Classes.InsertOnSubmit(clss);
            db.SubmitChanges();
            // Get the class ID
            clss = db.Classes.Where(x => x.TeacherID == teacher.UserID).First();
            // Assign students to the class
            for (int idx = 0; idx < studentsPerClass; nextStudent++, idx++)
            {
                User student = students[nextStudent];
                ClassStudent tie = new ClassStudent();
                tie.UserID = student.UserID;
                tie.ClassID = clss.ClassID;
                db.ClassStudents.InsertOnSubmit(tie);
            }
        }
        db.SubmitChanges();
    }
    /// <summary>
    /// Add defined level problems to the database
    /// </summary>
    private void AddProblems()
    {
        List<LevelRules> levels = null;
        using (StreamReader rdr = new StreamReader(Server.MapPath("App_Data/rules.json")))
        {
            levels = JsonConvert.DeserializeObject<List<LevelRules>>(rdr.ReadToEnd());
        }
        foreach (LevelRules level in levels)
        {
            AddLevelProblems(level);
        }
    }
    /// <summary>
    /// Add the problems for a level
    /// </summary>
    /// <param name="rules">Rules for the level</param>
    private void AddLevelProblems(LevelRules rules)
    {
        // Add level problems
        for (int op1 = rules.MinVal1; op1 < rules.MaxVal1; op1++)
        {
            for (int op2 = rules.MinVal2; op2 < rules.MaxVal2; op2++)
            {
                int sum = op1 + op2;
                if (sum < rules.MaxResult)
                {
                    AddRecord(rules.Level, op1, op2, sum, ProblemTypeEnum.Addition);
                }
            }
        }
        // subtraction
        for (int op1 = rules.MinVal2; op1 < rules.MaxVal2; op1++)
        {
            for (int op2 = rules.MinVal1; op2 <= op1 && op2 <= rules.MaxVal1; op2++)
            {
                int result = op1 - op2;
                AddRecord(rules.Level, op1, op2, result, ProblemTypeEnum.Subtraction);
            }
        }
        db.SubmitChanges();
    }
    /// <summary>
    /// Add an AddSubProblem to the database
    /// </summary>
    /// <param name="level">Problem level</param>
    /// <param name="op1">First Operand</param>
    /// <param name="op2">Second Operand</param>
    /// <param name="result">Result</param>
    /// <param name="prob">Problem type</param>
    private void AddRecord(int level, int op1, int op2, int result, ProblemTypeEnum prob)
    {
        {
            AddSubProblem problem = new AddSubProblem();
            problem.ProblemType = prob;
            problem.Level = level;
            problem.Operator1 = op1;
            problem.Operator1 = op2;
            problem.Result = result;
            db.AddSubProblems.InsertOnSubmit(problem);
        }
    }    /// <summary>
         /// Create and seed the database when the user clicks seed
         /// </summary>
         /// <param name="sender">not used</param>
         /// <param name="e">not used</param>
    protected void btnSeed_Click(object sender, EventArgs e)
    {
        CreateDatabase();
        SeedDatabase();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        db = new DataClassesDataContext();
        //AddStudents();
        //AddClasses();
        AddProblems();
    }
}