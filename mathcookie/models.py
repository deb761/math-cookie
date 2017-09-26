"""Data models for the Math with Cookie app"""
import os
import math
from enum import Enum
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


class User(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    login = db.Column(db.String(255))
    password = db.Column(db.String(255))
    first_name = db.Column(db.String(255))
    last_name = db.Column(db.String(255))
    results = db.relationship('Result', backref='student', lazy='dynamic')
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
    problemid = db.Column(db.Integer())
    answer = db.Column(db.Integer())
    level = db.Column(db.Integer())
    round = db.Column(db.Integer())


    def __repr__(self):
        return "<Result studentid={} problemid={}>".format(self.studentid, self.problemid)


class SchoolYear(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(255))
    start = db.Column(db.DateTime())
    end = db.Column(db.DateTime())
    classes = db.relationship('Class', backref='year', lazy='dynamic')


    def __repr__(self):
        return "<SchoolYear '{}'>".format(self.name)
  
  
class Class(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    yearid = db.Column(db.Integer(), db.ForeignKey('school_year.id'))
    teacherid = db.Column(db.Integer(), db.ForeignKey('user.id'))
    name = db.Column(db.String(255))
    students = db.relationship('User', secondary=classes,
                               backref=db.backref('posts', lazy='dynamic'))


    def __repr__(self):
        return "<Class '{}'>".format(self.name)
