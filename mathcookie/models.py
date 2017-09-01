"""Data models for the Math with Cookie app"""
import json
import os
from flask_sqlalchemy import SQLAlchemy

from mathcookie.extensions import bcrypt

db = SQLAlchemy()

roles = db.Table(
    'role_users',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('role_id', db.Integer, db.ForeignKey('role.id')))

classes = db.Table('class_students',
    db.Column('class_id', db.Integer, db.ForeignKey('class.id')),
    db.Column('student_id', db.Integer, db.ForeignKey('user.id'))
)

# Load the level/round rules
SITE_ROOT = os.path.realpath(os.path.dirname(__file__))
json_path = os.path.join(SITE_ROOT, "static/data", "rules.json")
levels = json.load(open(json_path))


class User(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    login = db.Column(db.String(255))
    password = db.Column(db.String(255))
    first_name = db.Column(db.String(255))
    last_name = db.Column(db.String(255))
    results = db.relationship('Result', backref='user', lazy='dynamic')
    roles = db.relationship('Role', secondary=roles, backref=db.backref('users', lazy='dynamic'))


    def __init__(self, login):
        self.login = login
        default = Role.query.filter_by(name='student').one()
        self.roles.append(default)


    def __repr__(self):
        return "<User '{}'>".format(self.login)


    def set_password(self, password):
        """Hash and store the password"""
        self.password = bcrypt.generate_password_hash(password).decode('utf-8')


    def check_password(self, password):
        """See if the input password matches the hash"""
        return bcrypt.check_password_hash(self.password, password)


    def is_authenticated(self):
        """True when the user is logged in"""
        if isinstance(self, AnonymousUserMixin):
            return False
        else:
            return True


    def is_active(self):
        return True


    def is_anonymous(self):
        """True when the user is not logged in"""
        if isinstance(self, AnonymousUserMixin):
            return True
        else:
            return False


    def get_id(self):
        return str(self.id)


class Role(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(80), unique=True)
    description = db.Column(db.String(255))


    def __repr__(self):
        return "<Role '{}'>".format(self.name)


class Result(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    studentid = db.Column(db.Integer(), db.ForeignKey('user.id'))
    problemid = db.Column(db.Integer(), db.ForeignKey('problem.id'))
    answer = db.Column(db.Integer())
    level = db.Column(db.Integer()) # can be more than 1
    round = db.Column(db.Integer())


    def __repr__(self):
        return "<Result studentid={} problemid={}>".format(self.studentid, self.problemid)


class SchoolYear(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(255))
    start = db.Column(db.DateTime())
    end = db.Column(db.DateTime())


    def __repr__(self):
        return "<SchoolYear '{}'>".format(self.name)


class ProblemType(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(20))


    def __repr__(self):
        return "<ProblemType '{}'>".format(self.name)


class Problem(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    level = db.Column(db.Integer())
    operand1 = db.Column(db.Integer())
    operand2 = db.Column(db.Integer())
    result = db.Column(db.Integer())
    problemtype = db.Column(db.Integer(), db.ForeignKey('problem_type.id'))
    results = db.relationship('Result', backref='problem', lazy='dynamic')


    def __repr__(self):
        return "<Problem 'level={}, {} {} {} = {}'>".format(
            self.level, self.operand1, self.problemtype.name, self.operand2, self.result)
  
  
class Class(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    yearid = db.Column(db.Integer(), db.ForeignKey('school_year.id'))
    teacherid = db.Column(db.Integer(), db.ForeignKey('user.id'))
    name = db.Column(db.String(255))
    students = db.relationship('User', secondary=classes,
                               backref=db.backref('posts', lazy='dynamic'))


    def __repr__(self):
        return "<Class '{}'>".format(self.name)
