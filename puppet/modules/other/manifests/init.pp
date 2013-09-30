class other 
{	
	$packages = [
		"curl", 
		"vim",
		"wget",
		"imagemagick",
		"nfs-common",
		"portmap",
		"php5-imagick"	
	]
	
	package 
	{ 
		$packages:
			ensure  => latest,
			require => Exec['apt-get update']
	}
}
