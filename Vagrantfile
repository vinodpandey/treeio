# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos-65-x64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/vagrant/treeio"

  # make symlinks work in shared /vagrant folder
  # will require the machine to run with admin previleges
  config.vm.provider :virtualbox do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  # fix for internet not working in vm issue
  config.vm.provision :shell, :inline => "sudo cp -f /vagrant/treeio/puppet/conf/resolv.conf /etc/resolv.conf"


  #inline shell stuff

  # turnoff firewall
  config.vm.provision :shell, :inline => "sudo /etc/init.d/iptables save"
  config.vm.provision :shell, :inline => "sudo /etc/init.d/iptables stop"
  # turnoff firewall on boot
  config.vm.provision :shell, :inline => "sudo chkconfig iptables off"

  


  # installing puppet modules
  # puppet module install puppetlabs/mysql --force --modulepath '/vagrant/treeio/puppet/modules'
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path    = "puppet/modules"
  end

  config.vm.provision :shell, :path => "puppet/scripts/python.sh"
  config.vm.provision :shell, :path => "puppet/scripts/virtualenv.sh"

end
