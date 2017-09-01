"""Manage the application"""
import os
from flask_script import Manager, Server
from flask_migrate import Migrate, MigrateCommand

from mathcookie import create_app
from mathcookie.models import db, User, Result, SchoolYear, Role, ProblemType
from mathcookie.models import Problem, Class

# default to dev config
env = os.environ.get('MATHCOOKIE_ENV', 'dev')
app = create_app('mathcookie.config.{}Config'.format(env.capitalize()))

migrate = Migrate(app, db)

manager = Manager(app)
manager.add_command("server", Server())
manager.add_command('db', MigrateCommand)

@manager.shell
def make_shell_context():
    return dict(app=app, db=db, User=User, Result=Result, SchoolYear=SchoolYear,
                Role=Role, ProblemType=ProblemType,
                Problem=Problem, Class=Class)

if __name__ == "__main__":
    manager.run()
