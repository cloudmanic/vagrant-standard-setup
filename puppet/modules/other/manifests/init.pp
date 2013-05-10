class other 
{	
	$packages = [
		"curl", 
		"vim",
		"wget",
		"nmap"
	]
	
	package 
	{ 
		$packages:
			ensure  => latest,
			require => Exec['apt-get update']
	}
}
