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

install_git_yum() {
    if ! command -v git &>/dev/null; then
        echo "Git missing. Installing..."
        sudo yum install -y git
    else
        echo "Git already installed."
    fi
}

install_git_apt() {
    sudo apt update -y

    if ! command -v git &>/dev/null; then
        echo "Git missing. Installing..."
        sudo apt install -y git
    else
        echo "Git already installed."
    fi
}

echo "Detected OS: $OS"

case "$OS" in
    amzn|rhel|centos)
        install_git_yum
        ;;
    ubuntu|debian)
        install_git_apt
        ;;
    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac

echo "Git installation complete!"
