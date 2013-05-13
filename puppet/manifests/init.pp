$use_xdebug = "1"

# Default path
Exec 
{
	path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

# Update apt-get
exec 
{ 
	'apt-get update':
		command => '/usr/bin/apt-get update',
		require => Exec['add php54 apt-repo']
}

# Remove www dir
exec
{
	'rm -rf /var/www':
		require => Package['lighttpd']
}

# Link up the www dir.
file 
{ 
	'/var/www':
  	ensure => 'link',
  	target => '/CloudmanicLabs/www',
  	require => Exec['rm -rf /var/www'],
  	notify => Service['lighttpd']
}

# Make it so phpmyadmin does not require a password.
file { "/etc/phpmyadmin/config.inc.php":
	ensure => present,
	owner => 'root',
	group => 'www-data',
	mode => 0640,
	source => "puppet:///modules/phpmyadmin/config.inc.php",
	require => [ Package['phpmyadmin'], Package['lighttpd'] ],
	notify => Service['lighttpd']
}

include bootstrap
include other
include mysql
include php54
include php
include lighttpd
include phpmyadmin
include redis
include beanstalkd
include memcached