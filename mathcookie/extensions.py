"""Extensions for the Math with Cookie application"""
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_principal import Principal, Permission, RoleNeed
from flask_admin import Admin

bcrypt = Bcrypt()

login_manager = LoginManager()
login_manager.login_view = "main.login"
login_manager.session_protection = "strong"
login_manager.login_message = "Please login to access this page"
login_manager.login_message_category = "info"

principals = Principal()
admin_permission = Permission(RoleNeed('admin'))
teacher_permission = Permission(RoleNeed('teacher'))
student_permission = Permission(RoleNeed('student'))

cookie_admin = Admin()

@login_manager.user_loader
def load_user(userid):
    from .models import User
    return User.query.get(userid)
