using Newtonsoft.Json;
using System.Collections.Generic;
using System.IO;
using System.Web;

/// <summary>
/// An enumeration that tracks problem type
/// </summary>
public enum ProblemTypeEnum { Addition, Subtraction, PlaceValue }
/// <summary>
/// An enumeration that tracks user type
/// </summary>
public enum UserTypeEnum { Student, Teacher, Administrator, Super }
/// <summary>
/// A class to define a round
/// </summary>
public class Round
{
    /// <summary>
    /// The types of problems in a round.  If more than one problem type is listed,
    /// the problems will be evenly divided by type and randomly mixed.
    /// </summary>
    public ProblemTypeEnum[] ProbTypes { get; set; }
    /// <summary>
    /// Total number of problems in the round
    /// </summary>
    public int NumProblems { get; set; }
}
/// <summary>
/// This class defines the rules for a level
/// </summary>
public class LevelRules
{
    /// <summary>
    /// The level number
    /// </summary>
    public int Level { get; set; }
    /// <summary>
    /// The minimum value for problem operator 1
    /// </summary>
    public int MinVal1 { get; set; }
    /// <summary>
    /// The maximum value for problem operator 1
    /// </summary>
    public int MaxVal1 { get; set; }
    /// <summary>
    /// The minimum value for problem operator 2
    /// </summary>
    public int MinVal2 { get; set; }
    /// <summary>
    /// The maximum value for problem operator 2
    /// </summary>
    public int MaxVal2 { get; set; }
    /// <summary>
    /// Maximim value for result
    /// </summary>
    public int MaxResult { get; set; }
    /// <summary>
    /// True if placevalue problems should be included
    /// </summary>
    public bool PlaceVal { get; set; }
    /// <summary>
    /// Rounds in the level
    /// </summary>
    public Round[] Rounds { get; set; }
}
/// <summary>
/// This class is used to provide general problem definition and creation
/// </summary>
public static class Rules
{
    /// <summary>
    /// The rules for each level
    /// </summary>
    public static Dictionary<int, LevelRules> Levels { get; private set; }
    /// <summary>
    /// Load the levels from rules.json
    /// </summary>
    /// <param name="server">Server object</param>
    public static void Load(HttpServerUtility server)
    {
        List<LevelRules> levels = null;
        Levels = new Dictionary<int, LevelRules>();
        using (StreamReader rdr = new StreamReader(server.MapPath("App_Data/rules.json")))
        {
            levels = JsonConvert.DeserializeObject<List<LevelRules>>(rdr.ReadToEnd());
            foreach (LevelRules level in levels)
            {
                Levels[level.Level] = level;
            }
        }
    }
}
