Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


exec { "grab-epel":
		command => "/bin/rpm -Uvh /vagrant/treeio/puppet/conf/epel-release-6-8.noarch.rpm",
		creates => "/etc/yum.repos.d/epel.repo",
		alias   => "grab-epel",
}

# mysql
class { '::mysql::server':
  root_password    => 'vagrant'
}

# apache
class {'apache':}
#apache::mod { 'proxy': }
#apache::mod { 'proxy_http': }
include apache::mod::php

apache::vhost { 'example.com':
  port    => '80',
  docroot => '/var/www/html',
  proxy_pass => [
   { 'path' => '/', 'url' => 'http://localhost:8000/' },
  ]
}

#php
php::ini { '/etc/php.ini':
  display_errors => 'On',
  memory_limit   => '256M',
}
php::ini { '/etc/httpd/conf/php.ini':
  mail_add_x_header => 'Off',
  # For the parent directory
  require => Package['httpd'],
}

class { 'php::mod_php5': inifile => '/etc/httpd/conf/php.ini' }


# Ensure Git is installed
package { "git": ensure => present }

# Ensure mysql-devel present, for mysql-python in django 
package { "mysql-devel": ensure => present }

# for applying django_related_fields patch
package { "patch": ensure => present }

# phpMyAdmin
class phpmyadmin {
  package { "phpMyAdmin":
    ensure  => present,
    require => Exec['grab-epel'],
  }

  file { "/etc/httpd/conf.d/phpMyAdmin.conf":
		owner   => "root",
		group   => "root",
		mode    => 644,
		replace => true,
		ensure  => present,
		source  => "/vagrant/treeio/puppet/conf/phpMyAdmin.conf",
		require => Package["httpd"],
		notify  => Service["httpd"],
  }
}
include phpmyadmin


#proxy pass
#apache::vhost { 'loc.test':
#  docroot     => '/var/www/html',
#  proxy_pass => [
#   { 'path' => '/a', 'url' => 'http://localhost:8000/' },
#  ],
#}

