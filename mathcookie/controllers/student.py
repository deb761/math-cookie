"""Blueprint for the student views"""
from flask import render_template, Blueprint, session, redirect, url_for, abort
from flask_login import login_required, current_user

from mathcookie.extensions import student_permission
from mathcookie.models import db, User, Class, Result
from mathcookie.problems import Problem
from mathcookie.rules import levels
from mathcookie.forms import AnswerForm

from .lesson import Lesson

student_blueprint = Blueprint('student', __name__, template_folder='../templates/student',
                              url_prefix='/student')


@student_blueprint.route('/')
@login_required
@student_permission.require(http_exception=403)
def index():
    """Set up a game session"""
    round_rules = levels[0].rounds[0]
    lesson = Lesson(current_user)
    # use the first value here, as ProblemSet needs to be modified to handle more than
    # one problem type
    problem_type = round_rules.probtypes[0]
    session["current_problem_type"] = problem_type
    session["lesson"] = lesson.__dict__
    session["problem_num"] = 0
    session["game_over"] = False
    session["num_right"] = 0
    session["num_wrong"] = 0

    return render_template('index.html', lesson=lesson)


@student_blueprint.route('/play', methods=['GET', 'POST'])
@login_required
@student_permission.require(http_exception=403)
def play():
    """Get the current problem within the lesson and display it for GET.
    For POST, check the answer against the problem result and let the user
    know if he got it right"""
    form = AnswerForm()
    lesson = Lesson(session['lesson'])
    problem = Problem(id=lesson.problems[session['problem_num']])

    if form.validate_on_submit():
        result = Result(studentid=current_user.id, problemid=problem.id,
                        answer=form.answer.data, level=lesson.level, round=lesson.round_num)
        db.session.add(result)
        db.session.commit()
        if form.answer.data == problem.result:
            session['num_right'] += 1
            return redirect(url_for('student.feedback', grade='right'))

        session['num_wrong'] += 1
        return redirect(url_for('student.feedback', grade='wrong'))

    return render_template('problem.html', problem=problem, form=form)


@student_blueprint.route('/feedback/<string:grade>')
@login_required
@student_permission.require(http_exception=403)
def feedback(grade):
    """Reward the user for giving the right answer, let her know the correct
    answer if wrong, and get ready for the next
    """
    if grade not in ['right', 'wrong', 'summary']:
        abort(404)

    problem = None
    finished = False
    if grade != 'summary':
        lesson = Lesson(session['lesson'])
        problem = Problem(id=lesson.problems[session['problem_num']])
        session['problem_num'] += 1
        if session['problem_num'] >= len(lesson.problems):
            # finished round
            finished = True

    return render_template('feedback.html', problem=problem, grade=grade, finished=finished)
