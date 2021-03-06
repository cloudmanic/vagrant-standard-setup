class php 
{
	$packages = [
		"php5", 
		"php5-cli",
		"php5-cgi",
		"php5-mysql", 
		"php-pear", 
		"php5-dev", 
		"php-apc", 
		"php5-mcrypt", 
		"php5-gd", 
		"php5-curl",
		"php5-xdebug",
		"php5-memcache",
		"php5-common",
		"php5-sqlite",
		"php5-geoip",
		"make",
		"libpcre3-dev",
		"liboauth-php"
	]
	
	package 
	{ 
		$packages:
			ensure  => latest,
			require => [Exec['apt-get update'], Package['python-software-properties']]
	}
  
	package { 'git-core':
		ensure => present,
	}

	exec { 'install composer':
		command => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin',
		require => [Package['curl'], Package['php5-cli']],
	}

	exec { 'global composer':
		command => "sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer",
		require => Exec['install composer'],
	} 

  file { "/usr/lib/php5/20100525+lfs/oauth.so":
  	ensure => present,
  	owner => 'root',
  	group => 'root',
  	mode => 0644,
  	source => "puppet:///modules/php/oauth.so",
  	require => [ Package['php5-cli'], Package['php5'] ]
  }
  
	exec
	{
		"echo extension=/usr/lib/php5/20100525+lfs/oauth.so > /etc/php5/conf.d/oauth.ini":
			require => File['/usr/lib/php5/20100525+lfs/oauth.so']
	}
	
  file { "/etc/php5/cli/php.ini":
  	ensure => present,
  	owner => 'root',
  	group => 'root',
  	mode => 0644,
  	source => "puppet:///modules/php/cli-php.ini",
  	require => Package['php5-cli']
  }
  
  file { "/etc/php5/cgi/php.ini":
  	ensure => present,
  	owner => 'root',
  	group => 'root',
  	mode => 0644,
  	source => "puppet:///modules/php/cgi-php.ini",
  	require => Package['php5']
  }  
}
