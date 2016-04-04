#!/usr/bin/env bash
# this script installs Ansible into the VM so we can use it with provisioning
if [ ! -f /etc/ansible/hosts ];
then
    echo "Installing Ansible..."
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible

	# add ansible hosts inventory
	sudo mkdir -p /etc/ansible
	printf 'localhost\n' | sudo tee /etc/ansible/hosts > /dev/null
fi
echo "Ansible is installed."
