using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Solstice.Models
{
    public class User
    {
        public int UserID { get; set; }
        public UserType UserType { get; set; }
        public string Login { get; set; }
        public string PasswordHash { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    public enum UserType { Student, Teacher, Administrator }
}
