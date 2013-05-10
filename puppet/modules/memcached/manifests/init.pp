class memcached 
{
	package { 'memcached':
		ensure => present,
		require => Exec['apt-get update']
	}
	
    
	service 
	{ 
		"memcached":
			enable => true,
			ensure => running,
			require => Package['memcached']
	}
}