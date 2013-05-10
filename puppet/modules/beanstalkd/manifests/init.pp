class beanstalkd 
{
	package { 'beanstalkd':
		ensure => present,
		require => Exec['apt-get update']
	}
	
	exec 
	{ 
		'sed "s/BEANSTALKD_LISTEN_ADDR=0.0.0.0/BEANSTALKD_LISTEN_ADDR=127.0.0.1/i" -i /etc/default/beanstalkd':
			require => Package['beanstalkd'],
	}
	
	exec 
	{ 
		'sed "s/#START=yes/START=yes/i" -i /etc/default/beanstalkd':
			require => Package['beanstalkd'],
	}
	
	service 
	{ 
		"beanstalkd":
			enable => true,
			ensure => running,
			require => [
				Exec['sed "s/BEANSTALKD_LISTEN_ADDR=0.0.0.0/BEANSTALKD_LISTEN_ADDR=127.0.0.1/i" -i /etc/default/beanstalkd'],
				Exec['sed "s/#START=yes/START=yes/i" -i /etc/default/beanstalkd']
			]
	}
}