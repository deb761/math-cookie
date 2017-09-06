"""Test the application routes"""
import unittest
from .extensions import bcrypt, login_manager, principals, cookie_admin

class TestURLs(unittest.TestCase):
    def setUp(self):
        # Bug workarounds
        cookie_admin._views = []
        
        app = create_app('mathcookie.config.TestConfig')
        self.client = app.test_client()
        
        # Bug workaround
        db.app = app

        db.create_all()


    def tearDown(self):
        db.session.remove()
        db.drop_all()
    def test_root_redirect(self):
        """Tests if the root URL gives a 302"""
        result = self.client.get('/')
        assert result.status_code == 302
        assert 'Cookie' in result.headers['Location']


if __name__ == '__main__':
    unittest.main()
