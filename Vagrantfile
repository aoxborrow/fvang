# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# get our project name from ansible config
current_dir = File.dirname(File.expand_path(__FILE__))
project_vars = YAML.load_file("#{current_dir}/ansible/roles/common/vars/main.yml")

PROJECT_NAME = project_vars['project_name']
VAGRANTFILE_API_VERSION = "2"
VAGRANT_IP = "192.168.33.11"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network :private_network, ip: VAGRANT_IP
  config.vm.synced_folder ".", "/home/vagrant/#{PROJECT_NAME}", type: "nfs"
  config.vm.provision :shell, keep_color: true, privileged: false, :path => "ansible/provision.sh"
  config.ssh.insert_key = false

  config.vm.provider "vmware_fusion" do |vf|
    vf.gui = true
    vf.vmx['displayname'] = PROJECT_NAME
    vf.vmx["memsize"] = "1024"
    vf.vmx["numvcpus"] = "2"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.name = PROJECT_NAME
    vb.memory = "1024"
    vb.cpus = 2
  end
end
