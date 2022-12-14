#!/usr/bin/env bash

mkdir -p /root/.ssh
mv /tmp/id_rsa*  /root/.ssh/

chmod 400 /root/.ssh/id_rsa*
chown root:root  /root/.ssh/id_rsa*

cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 400 /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys

echo "127.0.0.1 $(hostname)" >> /etc/hosts

echo "Installing k3s v1.21.4+k3s1..."
export INSTALL_K3S_VERSION=v1.21.4+k3s1
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --advertise-address=192.168.56.110 --node-ip=192.168.56.110"
curl -sfL https://get.k3s.io | sh -

echo "Setting up aliases"
echo "alias k='kubectl'" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc