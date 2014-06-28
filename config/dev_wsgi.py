import os, sys

PROJECT_PATH = os.path.realpath(os.path.join(os.path.dirname(__file__), ".."))
VIRTUAL_ENV_PATH = os.path.join(PROJECT_PATH, "..")

CODE_PATH = PROJECT_PATH
SETTINGS_PATH = CODE_PATH + '/config'
#EGG_CACHE_PATH = PROJECT_PATH + '/python_eggs'

LIB_PATH = VIRTUAL_ENV_PATH + '/lib/python2.7/site-packages'

sys.path = [PROJECT_PATH, CODE_PATH, LIB_PATH, SETTINGS_PATH, VIRTUAL_ENV_PATH] + sys.path
os.environ['DJANGO_SETTINGS_MODULE'] = 'config.dev'


# This application object is used by any WSGI server configured to use this
# file. This includes Django's development server, if the WSGI_APPLICATION
# setting points here.
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

# gunicorn config.dev_wsgi:application --bind=0.0.0.0:8000 --workers 9 --daemon