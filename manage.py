# encoding: utf-8
# Copyright 2011 Tree.io Limited
# This file is part of Treeio.
# License www.tree.io/license

#!/usr/bin/env python
from django.core.management import execute_manager
import imp
import os
import sys
try:
    imp.find_module('settings')  # Assumed to be in the same directory.
except ImportError:
    import sys
    sys.stderr.write(
        "Error: Can't find the file 'settings.py' in the directory containing %r. It appears you've customized things.\nYou'll have to run django-admin.py, passing it your settings module.\n" % __file__)
    sys.exit(1)

sys.path.append(os.path.realpath(os.path.join(os.path.dirname(__file__), "config")))
sys.path.append(os.path.realpath(os.path.join(os.path.dirname(__file__), "settings")))
sys.path.append(os.path.realpath(os.path.join(os.path.dirname(__file__), ".")))
sys.path.append(os.path.realpath(os.path.join(os.path.dirname(__file__), "..")))

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.dev")


from config import dev

if __name__ == "__main__":
    execute_manager(dev)
