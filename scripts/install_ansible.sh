#!/bin/bash
set -e

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS! Exiting."
    exit 1
fi



install_ansible_yum() {
    echo "Installing Ansible..."
    sudo yum check-update || true
    sudo yum install -y ansible
}

install_ansible_apt() {
    echo "Installing Ansible..."
    sudo apt update -y
    sudo apt install -y ansible
}

echo "Detected OS: $OS"

case "$OS" in
    ubuntu|debian)
        install_ansible_apt
        ;;
    amzn|rhel|centos|fedora)
        install_ansible_yum
        ;;
    *)
        echo "Unsupported OS: $OS"
        echo "Falling back to pip3 installation ..."
        if command -v pip3 &>/dev/null; then
             pip3 install --upgrade pip
             pip3 install --user ansible
             export PATH=$PATH:$HOME/.local/bin
        else
             echo "Error: pip3 not found. Cannot install Ansible."
             exit 1
        fi
        ;;
esac

echo "Ansible installation complete!"
ansible --version