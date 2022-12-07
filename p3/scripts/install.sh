sudo apt update -y
sudo apt upgrade -y

sudo apt install curl -y

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server" sh -s - --flannel-backend none