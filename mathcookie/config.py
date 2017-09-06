"""Define configurations for the Math with Cookie app"""
import os

class DevConfig(object):
    SQLALCHEMY_DATABASE_URI = 'postgres://bxveqfofqqielx:4042a3240f3509d83dc13b015b799501422d07ddf4ecd19e81226475ed14c939@ec2-54-225-88-191.compute-1.amazonaws.com:5432/d53ac8b6vgkom5'
    SECRET_KEY = '8389f90b2b276674cac869412b8a628b'
    DEBUG = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    RULES_PATH = os.path.join(os.path.realpath(os.path.dirname(__file__)), "static/data")
    # EXPLAIN_TEMPLATE_LOADING = True

class TestConfig(object):
    SQLALCHEMY_DATABASE_URI = 'postgres://bxveqfofqqielx:4042a3240f3509d83dc13b015b799501422d07ddf4ecd19e81226475ed14c939@ec2-54-225-88-191.compute-1.amazonaws.com:5432/d53ac8b6vgkom5'
    SECRET_KEY = '8389f90b2b276674cac869412b8a628b'
    DEBUG = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    RULES_PATH = os.path.join(os.path.realpath(os.path.dirname(__file__)), "static/data")
    # EXPLAIN_TEMPLATE_LOADING = True
