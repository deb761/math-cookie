using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Solstice.Models
{
    public class Result
    {
        public int ResultID { get; set; }
        public int StudentID { get; set; }
        public int ProblemID { get; set; }
        public int Level { get; set; }
        public int Round { get; set; }
    }
}
