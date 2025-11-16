#!/bin/bash
set -e

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS!"
    exit 1
fi

install_python_pip_yum() {
    echo "Checking python3..."
    if ! command -v python3 &>/dev/null; then
        echo "python3 not found. Installing..."
        sudo yum update -y
        sudo yum install -y python3
    else
        echo "python3 already installed."
    fi

    echo "Checking pip3..."
    if ! command -v pip3 &>/dev/null; then
        echo "pip3 not found. Installing..."
        sudo yum install -y python3-pip
    else
        echo "pip3 already installed."
    fi
}

install_python_pip_apt() {
    echo "Checking python3..."
    if ! command -v python3 &>/dev/null; then
        echo "python3 not found. Installing..."
        sudo apt update -y
        sudo apt install -y python3
    else
        echo "python3 already installed."
    fi

    echo "Checking pip..."
    if ! command -v pip3 &>/dev/null; then
        echo "pip not found. Installing..."
        sudo apt install -y python3-pip
    else
        echo "pip already installed."
    fi
}

echo "Detected OS: $OS"

case "$OS" in
    amzn|rhel|centos)
        install_python_pip_yum
        ;;
    ubuntu|debian)
        install_python_pip_apt
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac


echo "Calling Git installation script..."
bash install_ansible.sh


echo "Calling Ansible installation script..."
bash install_git.sh

echo "Python + Pip + Ansible + Git setup complete!"
