# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANT_IP = "192.168.33.11"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network :private_network, ip: VAGRANT_IP
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/home/vagrant/fvang", type: "nfs"
  config.vm.provision "shell" do |s|
      s.inline = "/home/vagrant/fvang/ansible/provision.sh dev.yml"
      s.keep_color = true
      s.privileged = false
  end

  config.vm.provider "vmware_fusion" do |vf|
    vf.gui = true
    vf.vmx['displayname'] = "fvang"
    vf.vmx["memsize"] = "1024"
    vf.vmx["numvcpus"] = "2"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.name = "fvang"
    vb.memory = "1024"
    vb.cpus = 2
  end
end
