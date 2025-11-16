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

echo "Detected OS: $OS"

case "$OS" in
    amzn|rhel|centos)
        echo "Running yum update..."
        sudo yum update -y
        ;;
    ubuntu|debian)
        echo "Running apt update..."
        sudo apt update -y
        ;;
    *)
        echo "Unsupported OS: $OS. Skipping update."
        exit 0
        ;;
esac

echo "System update complete!"