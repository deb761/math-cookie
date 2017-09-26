"""Control the admin pages"""
from flask import flash, url_for
from flask_admin import BaseView, expose
from flask_admin.contrib.fileadmin import FileAdmin
from flask_admin.contrib.sqla import ModelView
from flask_login import login_required, current_user

from mathcookie.extensions import admin_permission
from .init_database import load_users

class CustomView(BaseView):
    @expose('/')
    @login_required
    @admin_permission.require(http_exception=403)
    def index(self):
        return self.render('admin/index.html')
    
    @expose('/seed-db')
    @login_required
    @admin_permission.require(http_exception=403)
    def seed_db(self):
        load_users('teachers.json')
        load_users('students.json')
        flash("Seeded database with teachers and students")
        return self.render('admin/index.html')


class CustomModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and admin_permission.can()


class CustomFileAdmin(FileAdmin):
    def is_accessible(self):
        return current_user.is_authenticated and admin_permission.can()
