// Liz Fallin
// BIT 286 Project
// Spring Quarter 2016

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Solstice.Models
{
    public class Result
    {
        public int StudentID { get; set; }
        public int ProblemID { get; set; }
        public int Answer { get; set; }
        public int Level { get; set; }
        public int Round { get; set; }

    }
}
