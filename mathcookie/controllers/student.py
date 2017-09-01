"""Blueprint for the student views"""
from flask import render_template, Blueprint, session
from flask_login import login_required, current_user

from mathcookie.extensions import student_permission
from mathcookie.models import db, User, Class, levels

from .lesson import Lesson

student_blueprint = Blueprint('student', __name__, template_folder='../templates/student',
                              url_prefix='/student')


@student_blueprint.route('/home')
@login_required
@student_permission.require(http_exception=403)
def home():
    """Set up a game session"""
    round_rules = levels[0]['Rounds'][0]
    lesson = Lesson()
    # use the first value here, as ProblemSet needs to be modified to handle more than
    # one problem type
    problem_type = round_rules['ProbTypes'][0]
    session["current_problem_type"] = problem_type
    session["lesson"] = vars(lesson)
    session["problem_id"] = 0
    session["game_over"] = False
    session["num_correct"] = 0
    session["num_wrong"] = 0
    
    return render_template('home.html', lesson=lesson)
