class phpmyadmin 
{
	package 
	{ 
		"phpmyadmin":
			ensure  => present,
			require => [
				Exec['apt-get update'],
				Package["php5", "php5-mysql", "lighttpd"],
			]
	} 
}
