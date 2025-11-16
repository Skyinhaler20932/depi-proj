#!/bin/bash
set -e

echo "Checking if pip3 exists..."
if ! command -v pip3 &>/dev/null; then
    echo "pip3 is not installed. Run install_python.sh first!"
    exit 1
fi

# echo "Installing Ansible using pip3..."
# pip3 install --upgrade pip
# pip3 install ansible
sudo apt-get install -y ansible

echo "Ansible installation complete!"
ansible --version
