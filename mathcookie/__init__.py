import os

from flask import Flask, render_template, session, g, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_login import current_user
from flask_principal import identity_loaded, UserNeed, RoleNeed

from .extensions import bcrypt, login_manager, principals, cookie_admin
from .models import db, User, Class, Problem, ProblemType, Result, Role, SchoolYear
from .controllers.main import main_blueprint
from .controllers.student import student_blueprint
from .controllers.admin import CustomView, CustomModelView, CustomFileAdmin

def create_app(object_name):
    """Create the application object using the input config object"""
    app = Flask(__name__)
    app.config.from_object(object_name)

    db.init_app(app)
    bcrypt.init_app(app)
    login_manager.init_app(app)
    principals.init_app(app)
    cookie_admin.init_app(app)
    
    @identity_loaded.connect_via(app)
    def on_identity_loaded(sender, identity):
        # Set the identity user object
        identity.user = current_user
        
        # add the UserNeed to the identity
        if hasattr(current_user, 'id'):
            identity.provides.add(UserNeed(current_user.id))

        # add each role to the identity
        if hasattr(current_user, 'roles'):
            for role in current_user.roles:
                identity.provides.add(RoleNeed(role.name))

    @app.errorhandler(403)
    def admin():
        flash('not authorized')
        return redirect('/')


    @app.errorhandler(404)
    def page_not_found(error):
        return render_template('page_not_found.html'), 404

    app.register_blueprint(student_blueprint)
    app.register_blueprint(main_blueprint)
    
    cookie_admin.add_view(CustomView(name='Custom'))
    models = [User, Role, ProblemType, Problem, Result, SchoolYear, Class]
    for model in models:
        cookie_admin.add_view(CustomModelView(model, db.session, category='Models'))
    cookie_admin.add_view(CustomFileAdmin(os.path.join(os.path.dirname(__file__), 'static'),
                                          '/static/', name='Static Files'))

    return app
