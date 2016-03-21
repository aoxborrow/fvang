#!/usr/bin/env bash
# this script installs ansible into the VM so we can use it with provisioning
if [ ! -f /etc/ansible/hosts ];
then
    echo "Installing Ansible..."
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible

	# add ansible hosts inventory
	sudo mkdir -p /etc/ansible
	printf '[vagrant]\nlocalhost\n' | sudo tee /etc/ansible/hosts > /dev/null
fi
echo "Ansible is installed."

echo "Running playbook..."
PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -c local /home/vagrant/fvang/ansible/dev.yml
