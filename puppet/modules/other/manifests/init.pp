class other 
{	
	$packages = [
		"curl", 
		"vim",
		"wget",
		"imagemagick",
		"nfs-common",
		"portmap",
		"imagick-php5"
	]
	
	package 
	{ 
		$packages:
			ensure  => latest,
			require => Exec['apt-get update']
	}
}
