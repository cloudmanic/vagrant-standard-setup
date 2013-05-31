class other 
{	
	$packages = [
		"curl", 
		"vim",
		"wget",
		"nmap",
		"nfs-common",
		"portmap"
	]
	
	package 
	{ 
		$packages:
			ensure  => latest,
			require => Exec['apt-get update']
	}
}
