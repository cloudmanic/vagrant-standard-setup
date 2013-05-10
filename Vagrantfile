# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :private_network, ip: "192.168.60.100"
  config.vm.hostname = "dev2.cloudmanic.dev"
  
  # Set timezone
  config.vm.provision :shell, :inline => "echo \"America/Los_Angeles\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  
  # Setup Shares
  config.vm.synced_folder "/Users/spicer/CloudmanicLabs", "/CloudmanicLabs", :nfs => true
  
  # Configure with puppet
  config.vm.provision :puppet do |puppet|
  	puppet.manifests_path = "puppet/manifests"
  	puppet.manifest_file  = "init.pp"
  	puppet.module_path = "puppet/modules"
  	#puppet.options = "--verbose --debug"
  	#puppet.options = "--verbose"
  end
end