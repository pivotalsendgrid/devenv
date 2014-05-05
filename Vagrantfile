# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "devenv-berkshelf"
  config.vm.box = "opscode_ubuntu-12.04_provisionerless"
  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"
  config.omnibus.chef_version = :latest
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.boot_timeout = 120
  config.berkshelf.enabled = true
  
  config.vm.synced_folder "/home/trevor/workspace", "/home/vagrant/workspace"

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      devenv: {
        user: 'vagrant' 
      }
    }

    chef.run_list = [
        "recipe[devenv::default]",
        "recipe[devenv::vimgo]"
    ]
  end
end
