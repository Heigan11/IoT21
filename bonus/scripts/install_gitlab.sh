#!/bin/bash

sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

sudo EXTERNAL_URL="http://gitlab.example.com" apt-get install gitlab-ee
#sudo EXTERNAL_URL="http://192.168.56.110" apt-get install -y gitlab-ce

sudo cat /etc/gitlab/initial_root_password
