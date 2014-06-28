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
sudo /vagrant/bin/pip install -r treeio/requirements.pip
cd treeio
sudo python related_fields_patch.py /vagrant/lib/python2.7/site-packages/django

create database treeio (http://192.168.33.10/phpmyadmin)

python manage.py installdb
python manage.py loaddata data.json

deactivate

Running the server
===================
cd /vagrant/treeio/bin
./start.sh
./stop.sh


sudo pip2.7 install supervisor






Installing tree.io with Apache, Gunicorn, MySQL
================================================
