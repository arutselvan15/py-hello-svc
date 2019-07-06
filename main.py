import os

from flask import Flask

app = Flask('main')
  
@app.route('/')
def home():
  return 'Hello {} !'.format(os.environ.get("USER", "unknown-user"))

@app.route('/ping')
def ping():
  return 'pong'

@app.route('/code/<code>')
def code(code):
  return 'code ' + code, code

def print_version():
  try:                                            # pragma: no cover
    version = open('/etc/version.txt').readline() # pragma: no cover
    if version:                                   # pragma: no cover
      print(version)                              # pragma: no cover
  except Exception:                               # pragma: no cover
    pass                                          # pragma: no cover

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000)  # pragma: no cover
