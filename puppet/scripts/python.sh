PYTHON_VER="2.7.3"
EASY_INSTALL_VER="0.6.35"
VIRTUALENV_VER="1.9.1"

VER=(${PYTHON_VER//./ })
PYTHON_VER_MAJOR=${VER[0]}.${VER[1]}

# check python version, if version 2.7.3 not present, install it
if [[ $(python$PYTHON_VER_MAJOR -c 'import sys; print(".".join(map(str, sys.version_info[:3])))') != $PYTHON_VER_MAJOR.* ]]; then
    echo "Installing Python $PYTHON_VER"

    sudo yum -y install zlib zlib-devel gcc httpd-devel bzip2-devel sqlite-devel ncurses-devel
    mkdir -p ~/temp
    cd ~/temp
    wget --no-check-certificate http://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz
    tar zxvf Python-$PYTHON_VER.tgz
    cd Python-$PYTHON_VER
    ./configure --prefix=/usr/local --with-threads --enable-shared --with-zlib=/usr/include
    make
    sudo make altinstall
    cd ..
    cd ..
    rm -rf ~/temp
    sudo echo "/usr/local/lib" > python$PYTHON_VER_MAJOR.conf 
    sudo mv python$PYTHON_VER_MAJOR.conf /etc/ld.so.conf.d/python$PYTHON_VER_MAJOR.conf 
    sudo /sbin/ldconfig
    sudo ln -sfn /usr/local/bin/python$PYTHON_VER_MAJOR /usr/bin/python$PYTHON_VER_MAJOR
else
   echo "Python $PYTHON_VER_MAJOR.X present"
fi

# check easy_install, if not present, install it
if [[ $(easy_install-$PYTHON_VER_MAJOR --version) != distribute* ]]; then
    echo "Installing easy_install-$PYTHON_VER_MAJOR"
    wget --no-check-certificate  http://pypi.python.org/packages/source/d/distribute/distribute-$EASY_INSTALL_VER.tar.gz
    tar zxvf distribute-$EASY_INSTALL_VER.tar.gz
    cd distribute-$EASY_INSTALL_VER
    sudo python$PYTHON_VER_MAJOR setup.py install
    sudo ln -sfn /usr/local/bin/easy_install-$PYTHON_VER_MAJOR /usr/bin/easy_install-$PYTHON_VER_MAJOR
    cd ..
    sudo rm -rf distribute-$EASY_INSTALL_VER.tar.gz distribute-$EASY_INSTALL_VER
else
    echo "easy_install-$PYTHON_VER_MAJOR present"
fi

# check pip, if not present, install it
if [[ $(pip$PYTHON_VER_MAJOR --version) != pip* ]]; then
   echo "Installing pip" 
   sudo easy_install-$PYTHON_VER_MAJOR pip
   sudo ln -sfn /usr/local/bin/pip$PYTHON_VER_MAJOR /usr/bin/pip$PYTHON_VER_MAJOR
else
   echo "pip$PYTHON_VER_MAJOR present"
fi


# check if virtualenv is present, otherwise install it
if [[ $(virtualenv-$PYTHON_VER_MAJOR --version) != $VIRTUALENV_VER* ]]; then
    echo "Installing virtualenv"
    sudo pip$PYTHON_VER_MAJOR install virtualenv==$VIRTUALENV_VER
    sudo ln -sfn /usr/local/bin/virtualenv-$PYTHON_VER_MAJOR /usr/bin/virtualenv-$PYTHON_VER_MAJOR
else
    echo "virtualenv-$PYTHON_VER_MAJOR v$VIRTUALENV_VER present"
fi



