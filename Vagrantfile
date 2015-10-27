# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# get our project name from ansible config
current_dir = File.dirname(File.expand_path(__FILE__))
project_vars = YAML.load_file("#{current_dir}/ansible/project_vars.yml")
project_name = project_vars['project_name']


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/ubuntu-14.04"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.11"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # default shared folder
  config.vm.synced_folder ".", "/home/vagrant/#{project_name}", type: "nfs"

  # use the vagrant insecure key everytime, so PuTTY and PyCharm users don't have to worry about known hosts
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # to install the vmware plugin and license for your OS:
  # Mac:
  # vagrant plugin install vagrant-vmware-fusion
  # vagrant plugin license vagrant-vmware-fusion license.lic

  # Windows:
  # vagrant plugin install vagrant-vmware-workstation
  # vagrant plugin license vagrant-vmware-workstation license.lic

  # try these providers in order
  config.vm.provider "vmware_fusion"
  config.vm.provider "vmware_workstation"
  config.vm.provider "virtualbox"

  config.vm.provider "vmware_fusion" do |vf|
    vf.gui = true
    vf.vmx['displayname'] = project_name
    vf.vmx["memsize"] = "1024"
    vf.vmx["numvcpus"] = "2"
  end

  config.vm.provider "vmware_workstation" do |vw|
    vw.gui = true
    vw.vmx['displayname'] = project_name
    vw.vmx["memsize"] = "1024"
    vw.vmx["numvcpus"] = "2"
    vw.vmx["vmci0.present"] = "FALSE"
  end

 config.vm.provider "virtualbox" do |vb|
   vb.gui = true
   vb.name = project_name
   vb.memory = "1024"
   vb.cpus = 2
  end

  # Ansible provisioner, can't use because of windows
  # a plugin solution is available:
  # https://github.com/vovimayhem/vagrant-guest_ansible
  # config.vm.provision "ansible" do |ansible|
  #   ansible.playbook = "ansible/dev.yml"
  #   ansible.host_key_checking = false
  #   ansible.verbose = "vvvv"
  # end

  # run install_ansible.sh script to install ansible into the Vagrant VM
  # then we use Ansible within the VM to run our playbook
  $script = <<EOS
  set -e
  cd /home/vagrant/#{project_name}/ansible/
  ./install_ansible.sh
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -c local -i "localhost," dev.yml
EOS

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision :shell, keep_color: true, privileged: false, inline: $script

end
