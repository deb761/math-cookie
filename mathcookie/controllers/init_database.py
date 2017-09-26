"""Fill in basic data for the Math with Cookie database"""
import json
import os
from flask_sqlalchemy import SQLAlchemy
import mathcookie.rules as rules
from mathcookie.models import db, User

def load_users(path):
    """Load user definitions from a json file

    :param path: path to the file
    :returns: List of users
    """

    # Load the level/round rules
    json_path = os.path.join(rules.SITE_ROOT, "static/data", path)
    names = json.load(open(json_path))
    for name in names:
        user = User(name['FirstName'].lower())
        user.first_name = name['FirstName']
        user.last_name = name['LastName']
        user.set_password(user.login)
