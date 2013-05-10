class lighttpd
{
	package{'lighttpd':
		ensure => installed,
	}
	
	package{'apache2':
    ensure => absent,
    require => Package['lighttpd']
  }
  
  file { "/etc/lighttpd/lighttpd.conf":
  	ensure => present,
  	owner => 'root',
  	group => 'root',
  	mode => 0644,
  	source => "puppet:///modules/lighttpd/lighttpd.conf",
  	require => Package['lighttpd']
  }
  
  file { "/etc/lighttpd/conf-available/10-simple-vhost.conf":
  	ensure => present,
  	owner => 'root',
  	group => 'root',
  	mode => 0644,
  	source => "puppet:///modules/lighttpd/10-simple-vhost.conf",
  	require => Package['lighttpd'],
  	notify => Service['lighttpd']
  }
  
  file { '/etc/lighttpd/conf-enabled/05-auth.conf':
  	ensure => 'link',
  	target => '/etc/lighttpd/conf-available/05-auth.conf',
  	require => Package['lighttpd'],
  	notify => Service['lighttpd']
  }
  
  file { '/etc/lighttpd/conf-enabled/10-accesslog.conf':
  	ensure => 'link',
  	target => '/etc/lighttpd/conf-available/10-accesslog.conf',
  	require => Package['lighttpd'],
  	notify => Service['lighttpd']
  }
  
  file { '/etc/lighttpd/conf-enabled/10-fastcgi.conf':
  	ensure => 'link',
  	target => '/etc/lighttpd/conf-available/10-fastcgi.conf',
  	require => Package['lighttpd'],
  	notify => Service['lighttpd']
  }
  
  file { '/etc/lighttpd/conf-enabled/15-fastcgi-php.conf':
  	ensure => 'link',
  	target => '/etc/lighttpd/conf-available/15-fastcgi-php.conf',
  	require => Package['lighttpd'],
  	notify => Service['lighttpd']
  }
  
  file { '/etc/lighttpd/conf-enabled/50-phpmyadmin.conf':
  	ensure => 'link',
  	target => '/etc/phpmyadmin/lighttpd.conf',
  	require => Package['lighttpd', 'phpmyadmin'],
  	notify => Service['lighttpd']
  }
  
  file { '/etc/lighttpd/conf-enabled/10-simple-vhost.conf':
  	ensure => 'link',
  	target => '/etc/lighttpd/conf-available/10-simple-vhost.conf',
  	require => [ Package['lighttpd'], File['/etc/lighttpd/conf-available/10-simple-vhost.conf'] ],
  	notify => Service['lighttpd']
  }  
  
  service{ lighttpd:
  	ensure => running,
  	enable => true,
  	hasstatus => true,
  	require => [
  		Package['lighttpd'],
  		File['/etc/lighttpd/lighttpd.conf'],
  		File['/etc/lighttpd/conf-available/10-simple-vhost.conf'],
  		File['/etc/lighttpd/conf-enabled/05-auth.conf'],
  		File['/etc/lighttpd/conf-enabled/10-accesslog.conf'],
  		File['/etc/lighttpd/conf-enabled/10-fastcgi.conf'],
  		File['/etc/lighttpd/conf-enabled/15-fastcgi-php.conf'],
  		File['/etc/lighttpd/conf-enabled/50-phpmyadmin.conf'],
  		File['/etc/lighttpd/conf-enabled/10-simple-vhost.conf']
 		]  		
  }
}