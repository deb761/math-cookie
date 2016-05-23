using CryptSharp;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SecretSeedDatabase : ProtectedPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Redirect(UserType.Super))
            return;

    }
    DataClassesDataContext db;
    public void CreateDatabase()
    {
        db = new DataClassesDataContext(Server.MapPath("App_Data/solstice.mdf"));
        if (db.DatabaseExists())
        {
            Console.WriteLine("Deleting old database...");
            db.DeleteDatabase();
        }
        db.CreateDatabase();
    }
    private void SeedDatabase()
    {
        AddUsers();
    }

    private void AddEnums()
    {
        for (UserType utype = UserType.Student; utype <= UserType.Super; ++utype)
        {
            //db.UserTypes
        }
    }
    private void AddUsers()
    {
        List<User> users = LoadUsers("admins.json");
        List<User> teachers = LoadUsers("teachers.json");
        foreach (User teach in teachers)
        {
            teach.Login = teach.FirstName.ToLower();
            users.Add(teach);
        }
        List<User> students = LoadUsers("students.json");
        foreach (User kid in students)
        {
            kid.Login = kid.FirstName.ToLower();
            users.Add(kid);
        }

        foreach (User user in users)
        {
            string salt = Crypter.Blowfish.GenerateSalt(6);
            // login + userID
            string password = user.Login;
            string crypted = Crypter.Blowfish.Crypt(key: Encoding.ASCII.GetBytes(password),
                 salt: salt);
            user.Password = crypted + salt;
        }
        db.Users.InsertAllOnSubmit(users);
        db.SubmitChanges();
    }

    private List<User> LoadUsers(string path)
    {
        List<User> users = null;
        using (StreamReader rdr = new StreamReader(Server.MapPath("App_Data/" + path)))
        {
            users = JsonConvert.DeserializeObject<List<User>>(rdr.ReadToEnd());
        }
        return users;
    }

    private void AddClasses()
    {
        // Create a class year
        SchoolYear year = new SchoolYear();
        year.Name = "2015-2016";
        year.Start = DateTime.Parse("8-15-2015");
        year.End = DateTime.Parse("5-15-2016");
        db.SchoolYears.InsertOnSubmit(year);
        db.SubmitChanges();

        // Create a class for each teacher
        // Get the teachers and students with their IDs
        var teachers = db.Users.Where(x => x.UserType == UserType.Teacher);
        User[] students = db.Users.Where(x => x.UserType == UserType.Student).ToArray();
        int nextStudent = 0;

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
            for (int idx = 0; idx < students.Length / teachers.Count(); nextStudent++, idx++)
            {
                User student = students[nextStudent];
                ClassStudent tie = new ClassStudent();
                tie.UserID = student.UserID;
                tie.ClassID = clss.ClassID;
                db.ClassStudents.InsertOnSubmit(tie);
            }
        }
    }

    protected void btnSeed_Click(object sender, EventArgs e)
    {
        CreateDatabase();
        SeedDatabase();
    }
}