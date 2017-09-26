"""Track the problems and answers for a round"""
import werkzeug
from sqlalchemy import desc
from sqlalchemy.sql.expression import func

from mathcookie.rules import levels, Round
from mathcookie.models import db, User, Result
from mathcookie.problems import Problem, ProblemType


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

    def __init__(self, student):
        """Initialize lesson based on inputs
        """
        if isinstance(student, werkzeug.local.LocalProxy):
            self._init_from_user(student)
        else:
            self._init_from_dict(student)


    def _init_from_user(self, student):
        """Create a lession for the student"""
        last_result = student.results.order_by(desc(Result.id)).first()
        if last_result:
            self.level = last_result.level
            self.round_num = last_result.round
            level_rules = levels[self.level]
            round_result = student.results.filter_by(
                level=last_result.level, round=last_result.round)

            # If the student has for some reason completed more rounds
            # than exist for the level, increment the level
            if self.round_num > len(level_rules.rounds):
                self.next_round()

            # See if the student has completed the round
            else:
                self.round_rules = level_rules.rounds[last_result.round - 1]
                if round_result.count() >= self.round_rules.numproblems:
                    self.next_round()

        else:
            self.level = 1
            self.round_num = 1
            self.round_rules = levels[self.level - 1].rounds[0]
            complete = False

        self.description = ' and '.join(self.round_rules.probtypes)
        self.problems = [x.id for x in self.get_problems(student)]
        self.__dict__['round_rules'] = self.round_rules.__dict__


    def _init_from_dict(self, dictionary):
        """Convert from a dictionary to a lesson"""
        self.__dict__ = dictionary
        self.round_rules = Round(dictionary['round_rules'])
        self.__dict__['round_rules'] = self.round_rules.__dict__


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
            self.round_rules = levels[self.level].rounds[0]

        else:
            self.round_num += 1

        self.round_rules = level_rules.rounds[self.round_num - 1]


    def get_problems(self, student):
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

        for problem_type in self.round_rules.probtypes:
            missed_problems += self.get_retest_problems(student, problem_type)

            # Now get a list of *new* problem IDs for this level and problem type
            new_problems += self.get_problem_ids(problem_type, self.level)

        # Finally, combine the lists.
        # For now, we will start with missed problem ids, 
        # and fill the rest of the list with new problem ids
        # There will be problem ids that are not covered in this round
        problems = []

        # At most, the number of missed problems to be shown
        # is the number of problems in the current round
        num_missed_shown = min(len(missed_problems), self.round_rules.numproblems)

        # If there are any problems not yet used, the slots will
        # be filled by new problems
        num_new_shown = self.round_rules.numproblems - num_missed_shown

        if num_missed_shown:
            problems = missed_problems[:num_missed_shown]

        problems += new_problems[:num_new_shown]

        return problems


    def get_retest_problems(self, student, problem_type):
        """Get any problems that should be retested"""
        retest = {}
        results = db.session.query(Result).filter(Result.studentid == student.id).join(
            Result.problem).filter(ProblemType.name == problem_type)
        missed_problems = results.filter(Result.answer != Problem.result).all()
        for missed in missed_problems:
            last_right = results.filter(Result.problemid == missed.id).filter(
                Result.answer == Problem.result).order_by(desc(Result.id)).first()
            if not last_right or last_right.id <= missed.id:
                retest[missed.problemid] = missed.problem

        return retest.values()


    def get_problem_ids(self, problem_type, level):
        problemtype = ProblemType.query.filter_by(name=problem_type).one()
        problems = Problem.query.filter_by(level=level, problemtypeid=problemtype.id).order_by(
            func.random()).limit(10).all()
        return problems
