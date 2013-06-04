class other 
{	
	$packages = [
		"curl", 
		"vim",
		"wget",
		"imagemagick",
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
