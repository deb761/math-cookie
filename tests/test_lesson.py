import unittest
import pytest
from mathcookie.controllers.lesson import Lesson

from mathcookie import create_app
from mathcookie.models import db, User, Role, Result
from mathcookie.problems import ProblemType, Problem
from mathcookie.rules import levels
from mathcookie.extensions import bcrypt, login_manager, principals, cookie_admin


class TestLesson(unittest.TestCase):
    def setUp(self):
        # Bug workarounds
        cookie_admin._views = []

        app = create_app('mathcookie.config.TestConfig')
        self.client = app.test_client()
        
        # Bug workaround
        db.app = app

        db.create_all()
        student_role = Role(id=1, name='student')
        db.session.add(student_role)
        db.session.commit()
        self.student = User('bill')
        db.session.add(self.student)
        db.session.commit()


    def tearDown(self):
        db.session.remove()
        db.drop_all()


    def test_init_from_new_user(self):
        """Test that the lesson for a new user is created with level 1 round 1 problems"""
        lesson = Lesson(self.student)
        assert lesson.level == 1
        assert lesson.round_num == 1
        assert lesson.description == 'Addition'
        assert lesson.round_rules == levels[1].rounds[0].__dict__
        assert not lesson.complete
        assert len(lesson.problems) == levels[1].rounds[0].numproblems


    def test_next_round_in_level(self):
        lesson = Lesson(self.student)
        lesson.next_round()
        assert lesson.round_num == 2
        assert lesson.round_rules == levels[1].rounds[1]


    def test_next_round_new_level(self):
        lesson = Lesson(self.student)
        lesson.round_num = len(levels[1].rounds)
        lesson.next_round()
        assert lesson.level == 2
        assert lesson.round_num == 1
        assert lesson.round_rules == levels[2].rounds[0]


    def test_next_round_complete(self):
        """Test that next_round sets complete if the user has completed the last round
        of the last level
        """
        lesson = Lesson(self.student)
        lesson.level = 3
        lesson.round_num = len(levels[3].rounds)
        lesson.next_round()
        # assert lesson.level == 4
        assert lesson.complete


    def test_get_retest_problems(self):
        """Test that missed problems for the problem type are retrieved only if the
        last time the student was quizzed on them, the answer was wrong
        """
        for missed in [
            {'operand1' : 1, 'operand2' : 4, 'answer' : 6},
            {'operand1' : 2, 'operand2' : 4, 'answer' : 5},
            {'operand1' : 2, 'operand2' : 4, 'answer' : 6},
            ]:
            problem = Problem(
                level=1, problem_type=ProblemType.ADDITION, operand1=missed['operand1'],
                operand2=missed['operand2'])
            result = Result()
            result.level = 1
            result.round = 1
            result.problemid = problem.id
            result.studentid = self.student.id
            result.answer = missed['answer']
            db.session.add(result)
            
        lesson = Lesson(self.student)
