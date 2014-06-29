sudo mkdir -p /var/log/gunicorn
sudo cp -f /vagrant/treeio/puppet/conf/supervisord.conf /etc/supervisord.conf

if [[ $(supervisord -v) != 3.* ]]; then
    sudo pip2.7 install supervisor==3.0
    sudo ln -sfn /usr/local/bin/supervisord /usr/bin/supervisord
    sudo ln -sfn /usr/local/bin/supervisorctl /usr/bin/supervisorctl
else
    echo "supervisor 3.0 already present"
fi


# make sure supervisord is started and start gunicorn_treeio
sudo unlink /tmp/supervisor.sock
sudo /usr/bin/supervisord -c /etc/supervisord.conf
# sudo supervisorctl restart gunicorn_treeio