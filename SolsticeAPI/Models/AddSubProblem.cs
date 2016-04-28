using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Solstice.Models
{
    public class AddSubProblem
    {
        public int AddSubProblemID { get; set; }
        public int Level { get; set; }
        public int Operator1 { get; set; }
        public int Operator2 { get; set; }
        public int Result { get; set; }
        public ProblemType ProblemType { get; set; }
    }
    public enum ProblemType { Addition, Subtraction, PlaceValue }
}
