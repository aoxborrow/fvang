#!/usr/bin/env bash
# this script installs ansible into the VM so we can use it with provisioning
if [ ! -f /etc/ansible/hosts ];
then
    echo "Installing Ansible..."
	sudo apt-get update
	sudo apt-get install -y python-pip python-dev python-pycurl
	sudo pip install ansible
	
	# add ansible hosts inventory
	sudo mkdir -p /etc/ansible
	printf '[vagrant]\nlocalhost\n' | sudo tee /etc/ansible/hosts > /dev/null
	echo "Ansible is installed."
fi

echo "Running playbook..."
PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -c local /home/vagrant/fvang/ansible/dev.yml