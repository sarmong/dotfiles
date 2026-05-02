#!/bin/sh

set -eu

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: must run as root."
    exit 1
fi

USERNAME="${1:-$(awk -F: '$3 == 1000 {print $1}' /etc/passwd)}"

if [ -z "$USERNAME" ]; then
    echo "ERROR: Could not detect a normal user account. Pass username as argument."
    exit 1
fi

echo "==> Target user: $USERNAME"

export DEBIAN_FRONTEND=noninteractive

echo "==> Updating system..."
apt-get update
apt-get upgrade -y

echo "==> Installing base packages..."
apt-get install -y sudo openssh-server avahi-daemon

echo "==> Adding $USERNAME to sudo group..."
usermod -aG sudo "$USERNAME"

echo "==> Enabling SSH and Avahi..."
systemctl enable --now ssh
systemctl enable --now avahi-daemon

echo "==> Done. SSH is up, $USERNAME can now sudo."
echo "    Connect from LAN: ssh $USERNAME@$(hostname).local"
