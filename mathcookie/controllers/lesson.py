"""Track the problems and answers for a round"""
from mathcookie.models import levels

class Lesson:
    """
    Put the data related to a students current lesson in a class
    """

    #: Level the student is on
    level = 0

    #: Lesson within the level the student is on
    round_num = 0

    #: Round rules for the current round
    round_rules = None

    #: Description for the lesson
    description = ''

    #: True when the student has finished all levels
    complete = False

    def __init__(self, round_result=None):
        """Initialize lesson based on inputs
        """
        if round_result:
            self.level = round_result.level
            self.round_num = round_result.round
            level_rules = levels[self.level]
            # If the student has for some reason completed more rounds
            # than exist for the level, increment the level
            if self.round_num > len(level_rules.rounds):
                self.next_round()

            # See if the student has completed a round
            else:
                self.round_rules = level_rules.rounds[round_result.round - 1]
                if len(round_result) >= self.round_rules['NumProblems']:
                    self.next_round()
                else:
                    self.round_rules = level_rules.rounds[self.round_num - 1]

        else:
            self.level = 1
            self.round_num = 1
            self.round_rules = levels[self.level - 1]['Rounds'][0]
            complete = False

        self.description = ' and '.join(self.round_rules['ProbTypes'])


    def next_round(self):
        """
        Increment the Current Round to the next, incrementing the level if
        the student has finished it, and marking the student as complete if
        all levels are complete
        """
        level_rules = levels[self.level]
        # If the student has for some reason completed more rounds
        # than exist for the level, increment the level
        if self.round_num >= len(level_rules.rounds):
            # We expect that the highest level number will match the count of levels
            if self.level >= len(levels):
                self.complete = True
                return

            self.level += 1
            self.round_num = 1
            self.round_rules = levels[self.level]['Rounds'][0]

        else:
            self.round_num += 1

        self.round_rules = level_rules['Rounds'][self.round_num - 1]


    def get_problems(self, student_id):
        """
        Randomly fill problem list with problems from the appropriate level and problem type
        Query the Results table for id = StudentID, level = Level, and problem type = ProbType for
        failed problems.
        This should return a list of the missed problems of this type in this level.
        Use these values to start the problems list
        """

        # Get list of *missed* problem IDs for this level
        # This will form the first part of the problem list
        missed_problems = []
        new_problems = []

        for problem_type in self.round_rules['ProbTypes']:
            missed_problems += self.get_retest_problems(student_id, problem_type)

            # Now get a list of *new* problem IDs for this level and problem type
            new_problems += self.get_problem_ids(problem_type, level);

        # Finally, combine the lists.
        # For now, we will start with missed problem ids, 
        # and fill the rest of the list with new problem ids
        # There will be problem ids that are not covered in this round
        problems = []

        # At most, the number of missed problems to be shown
        # is the number of problems in the current round
        num_missed_shown = math.min(len(missed_problems), self.round_rules['NumProblems'])

        # If there are any problems not yet used, the slots will
        # be filled by new problems
        num_new_shown = self.round_rules['NumProblems'] - num_missed_shown

        if num_missed_shown:
            problems = missed_problems[:num_missed_shown]

        problems += new_problems[:self.round_rules['NumProblems'] - num_missed_shown]

        return problems


    def get_retest_problems(self, student_id, problem_type):
        """Get any problems that should be retested"""
        student = User.query.get(student_id)
        return []
        #         var missedProbs = GetMissedProblems(studentID, (int)probType);
        # foreach (GetMissedProblemsResult result in missedProbs)
        # {
        #     var lastRightResult = LastTimeRight(studentID: studentID, problemID: result.ProblemID);
        #     foreach (LastTimeRightResult last in lastRightResult)
        #     {
        #         if (last.Last < result.Last)
        #             missed.Add(result.ProblemID);
        #     }
        # }
        # return missed;


    def get_problem_ids(self, problem_type, level):
        return []
