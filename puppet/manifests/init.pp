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

include bootstrap
include other
#include mysql
include php54
include php
include lighttpd
include phpmyadmin
#include redis
#include beanstalkd
#include memcached