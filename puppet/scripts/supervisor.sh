sudo cp -f /vagrant/treeio/puppet/conf/supervisord.conf /etc/supervisord.conf
sudo pip2.7 install supervisor

# make sure supervisord is started and start gunicorn_treeio
sudo unlink /tmp/supervisor.sock
sudo /usr/bin/supervisord -c /etc/supervisord.conf
# sudo supervisorctl restart gunicorn_treeio