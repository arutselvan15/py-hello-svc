'''
:Author: Arut Selvan
'''

__updated__ = 'yyyy-MM-dd'

import unittest

from main import app

GET = 'GET'

class TestApi(unittest.TestCase):
  '''App unit test'''

  def setUp(self):
    '''Set up'''
    app.testing = True
    self.app = app.test_client()
    self.headers = {'Content-Type': 'text/html'}

  def tearDown(self):
    '''Tear Down'''
    self.app = None

  def _execute(self, method, path, *args, **kwargs):
    '''Execute request and return response'''
    return self.app.open(method=method, path=path, follow_redirects=True,
                         *args, **kwargs)

  def test_home(self):
    '''GET / 200'''
    response = self._execute(GET, '/')
    self.assertEqual(response.status_code, 200)

  def test_ping(self):
    '''GET /ping 200'''
    response = self._execute(GET, '/ping')
    self.assertEqual(response.status_code, 200)

  def test_invald_url_404(self):
    '''GET /invalid 404'''
    response = self._execute(GET, '/invalid')
    self.assertEqual(response.status_code, 404)

  def test_code_201(self):
    '''GET /code/201'''
    response = self._execute(GET, '/code/201')
    self.assertEqual(response.status_code, 201)

  def test_code_400(self):
    '''GET /code/400'''
    response = self._execute(GET, '/code/400')
    self.assertEqual(response.status_code, 400)

  def test_code_500(self):
    '''GET /code/500'''
    response = self._execute(GET, '/code/500')
    self.assertEqual(response.status_code, 500)
