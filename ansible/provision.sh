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
	printf 'localhost\n' | sudo tee /etc/ansible/hosts > /dev/null
fi
echo "Ansible is installed."

# get Ansible playbook dir -- ie. this script's directory
ANSIBLE_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$ANSIBLE_DIR" ]]; then ANSIBLE_DIR="$PWD"; fi

echo "Running playbook \"$1\"..."
PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -c local $ANSIBLE_DIR/$1
