# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  #ensure puppet and link to vm
  config.vm.host_name = "development.puppetlabs.vm"
  config.vm.network "forwarded_port", guest: 3000, host: 3003
  config.vm.provision :shell, :path => "install_puppet.sh"
  config.vm.synced_folder "puppet", "/puppet"

  # Puppet Provisioner setup
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "site.pp"
  end

end
