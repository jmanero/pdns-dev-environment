# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu-14.04-amd64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.berkshelf.enabled = true

  config.vm.define "pdns-build" do |node|
    node.vm.hostname = "pdns-build"
    node.vm.network :private_network, :ip => "192.168.50.3"
    node.vm.synced_folder "pdns-source/", "/usr/local/src/pdns"
    node.vm.provider :virtualbox do |vb|
      vb.memory = 4096
      vb.cpus = 4
    end

    node.vm.provision :chef_solo do |chef|
      chef.add_recipe "pdns::pdns_auth"
      chef.json = {
        :pdns => {
          :builder => "vagrant",
          :install => "source"
        }
      }
    end
  end

  ## Testing VMS
  config.vm.define "pdns-master" do |node|
    node.vm.hostname = "pdns-master"
    node.vm.network :private_network, :ip => "192.168.50.4"
    node.vm.provider :virtualbox do |vb|
      vb.memory = 1024
    end

    node.vm.provision :chef_solo do |chef|
      chef.add_recipe "pdns::pdns_auth"
    end
  end

  config.vm.define "bind-master" do |node|
    node.vm.hostname = "bind-master"
    node.vm.network :private_network, :ip => "192.168.50.5"
    node.vm.provision :chef_solo do |chef|
      chef.add_recipe "pdns::bind_master"
    end
  end

  config.vm.define "bind-slave" do |node|
    node.vm.hostname = "bind-slave"
    node.vm.network :private_network, :ip => "192.168.50.6"
    node.vm.provision :chef_solo do |chef|
      chef.add_recipe "pdns::bind_slave"
    end
  end

  config.vm.define "capture" do |node|
    node.vm.hostname = "capture"
    node.vm.network :private_network, :ip => "192.168.50.7"
    node.vm.provider :virtualbox do |vb|
      vb.memory = 4096
      vb.cpus = 4
      vb.gui = true
      vb.customize ["modifyvm", :id, "--vram", "128"]
    end

    node.vm.provision :chef_solo do |chef|
      chef.add_recipe "pdns::capture"
    end
  end
end
