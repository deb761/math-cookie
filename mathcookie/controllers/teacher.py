"""Blueprint for the teacher views"""
from flask import render_template, Blueprint, session, redirect, url_for, abort
from flask_login import login_required, current_user

from mathcookie.extensions import teacher_permission
from mathcookie.models import db, User, Class, Problem, Result
from mathcookie.rules import levels
from mathcookie.forms import AnswerForm

teacher_blueprint = Blueprint('teacher', __name__, template_folder='../templates/teacher',
                              url_prefix='/teacher')


@teacher_blueprint.route('/')
@login_required
@teacher_permission.require(http_exception=403)
def index():
    """Bring up teacher home page, show first class and allow teacher to select any other class"""
    classes = Class.query.filter_by(teacherid=current_user.id).all()
    
    class_id = classes[0].id if classes else -1

    if session.get('class_id') and classes:
        cid = session['class_id']
        if Class.query.get(cid).teacherid == current_user.id:
            class_id = cid

    return render_template('index.html', classes=classes, class_id=class_id)
