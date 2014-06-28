Modifications
==============
Added
+ conf
+ puppet
+ README.new.md
+ Vagrantfile

Updated
+ .gitignore
+ requirements.pip
+ manage.py

Setup DEV environment
======================
git clone https://github.com/vinodpandey/treeio
vagrant up
vagrant ssh
cd /vagrant
source bin/activate
pip install -r treeio/requirements.pip
cd /vagrant/lib/python2.7/site-packages/django
sudo patch -p1 < ../../../../code/bin/django-related-fields.patch

http://192.168.33.10/phpmyadmin
create database treeio



Installing tree.io with Apache, Gunicorn, MySQL
================================================
