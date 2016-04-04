# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANT_IP = "192.168.33.11"

Vagrant.require_version ">= 1.8"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network :private_network, ip: VAGRANT_IP
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/home/vagrant/fvang", type: "nfs"

  # this undoes the virtualenv for vagrant commands (ie. provision)
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # temporary hack until Vagrant 1.8.2:
  # https://github.com/mitchellh/vagrant/issues/6793
  config.vm.provision :shell, inline: <<SCRIPT
GALAXY=/usr/local/bin/ansible-galaxy
echo '#!/bin/sh
exit 0' | sudo tee $GALAXY > /dev/null
sudo chmod 0755 $GALAXY
SCRIPT

  # install Ansible within the VM and run our dev playbook
  config.vm.provision "ansible_local" do |ansible|
    ansible.install = true
    ansible.provisioning_path = "/home/vagrant/fvang/ansible"
    ansible.playbook = "dev.yml"
  end

  # add localhost to Ansible inventory
  config.vm.provision "shell", inline: "printf 'localhost\n' | sudo tee /etc/ansible/hosts > /dev/null"

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
