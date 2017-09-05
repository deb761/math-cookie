"""Fill in basic data for the Math with Cookie database"""
import json
import os
from flask_sqlalchemy import SQLAlchemy
import mathcookie.rules as rules
from mathcookie.models import db, User, Problem, ProblemType

def fill_in_problems():
    MAX_LEVEL1 = 10
    Problem.query.delete()
    if not Problem.query.all(): # table is empty
        for level in rules.levels:
            add_level_problems(level)


def add_level_problems(level_rules):
    """Add the problems for a level
    
    :param level_rules: Rules for the level
    """

    # Add level problems
    prob_type = ProblemType.query.filter_by(name='Addition').one()
    for op1 in range(level_rules.minval1, level_rules.maxval1):
        for op2 in range (level_rules.minval2, level_rules.maxval2):
            result = op1 + op2
            if result < level_rules.maxresult:
                problem = Problem(level=level_rules.level, operand1=op1, operand2=op2,
                                  result=result, problemtypeid=prob_type.id)
                db.session.add(problem)

    # subtraction
    prob_type = ProblemType.query.filter_by(name='Subtraction').one()
    for op1 in range(level_rules.minval1, level_rules.maxval1):
        for op2 in range (level_rules.minval2, level_rules.maxval2):
            result = op1 - op2
            if result >= 0:
                problem = Problem(level=level_rules.level, operand1=op1, operand2=op2,
                                  result=result, problemtypeid=prob_type.id)
                db.session.add(problem)

    db.session.commit()


def load_users(path):
    """Load user definitions from a json file

    :param path: path to the file
    :returns: List of users
    """

    # Load the level/round rules
    json_path = os.path.join(rules.SITE_ROOT, "static/data", path)
    names = json.load(open(json_path))
    for name in names:
        user = User(name['FirstName'].lower())
        user.first_name = name['FirstName']
        user.last_name = name['LastName']
        user.set_password(user.login)
