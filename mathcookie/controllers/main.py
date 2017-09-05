"""Blueprint for login views"""
from flask import render_template, redirect, url_for, Blueprint, current_app, flash
from flask_login import login_user, logout_user, login_required
from flask_principal import identity_changed, Identity, AnonymousIdentity

from mathcookie.models import db, User
from mathcookie.forms import LoginForm

main_blueprint = Blueprint('main', __name__, template_folder='/templates/main',
                           url_prefix='/')

@main_blueprint.route('/', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(login=form.username.data).one()
        # user is logged in
        login_user(user)
        
        identity_changed.send(current_app._get_current_object(),
                              identity=Identity(user.id))

        return redirect(url_for(user.roles[0].name + '.index'))

    return render_template('main/login.html', form=form)


@main_blueprint.route('logout', methods =['GET', 'POST'])
@login_required
def logout():
    """Remove the user and data from the session"""
    logout_user()
    identity_changed.send(current_app._get_current_object(),
                          identity=AnonymousIdentity())
    flash("You have been logged out.", category="success")
    return redirect(url_for('.login'))
