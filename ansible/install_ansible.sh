#!/usr/bin/env bash
# this script installs ansible into the VM so we can use it with provisioning
# this is necessary right now because Ansible doesn't run on Windows
if [ $(dpkg-query -W -f='${Status}' ansible 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    echo "Installing Ansible..."
    sudo apt-get install -y python-software-properties
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:rquillo/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
fi
echo "Ansible is installed."
# echo "Running playbook..."
# sudo ansible-playbook -i "localhost," /home/vagrant/fvang/ansible/dev.yml --connection=local
