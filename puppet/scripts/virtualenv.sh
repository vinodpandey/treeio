cd /vagrant
source bin/activate &> /dev/null
if [[ $? -eq 0 ]]; then
    echo 'virtualenv already present.'
else
    echo 'creating virtualenv'
    sudo virtualenv-2.7 --no-site-packages .
    # source bin/activate
    # sudo /vagrant/bin/pip install -r treeio/requirements.pip
    # deactivate
fi

