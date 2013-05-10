class redis {
	package { 'redis-server':
		ensure => installed,
		require => Exec['apt-get update']
	}
    
	service 
	{ 
		"redis-server":
			enable => true,
			ensure => running,
			require => Package['redis-server']
	}
}