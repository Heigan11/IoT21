#!/bin/bash

sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

sudo EXTERNAL_URL="http://10.0.2.15" apt-get install -y gitlab-ce

sudo cat /etc/gitlab/initial_root_password
