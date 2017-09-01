from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, IntegerField
from wtforms.validators import InputRequired, Length

from .models import User

class LoginForm(FlaskForm):
    """Login form for all users"""
    username = StringField('User Name', validators=[InputRequired(), Length(min=2, max=30)])
    password = PasswordField('Password', validators=[InputRequired()])

    def validate(self):
        """Verify the username and password match"""
        check_validate = super(LoginForm, self).validate()

        if check_validate:
            user = User.query.filter_by(login=self.username.data).first()
            if user:
                # do the passwords match
                if user.check_password(self.password.data):
                    return True

            self.username.errors.append('Invalid username or password')
            return False

        print(self.errors)
        return False
