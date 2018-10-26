#!/bin/bash
yum install -y sudo epel-release bash-completion vim net-tools sysstat git lshw; \
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh; \
echo "source ~/.git-prompt.sh" >> ~/.bashrc ;\
echo "PS1='\u@\$PNAME [\[\e[1;31m\]\$(__git_ps1 " %s")\[\e[0m\] \[\e[32m\]\$PWD\[\e[0m\] ]\n$ '" >> ~/.bashrc ;\
yum install -y htop ;\
git config --global color.ui auto ;\
cd / ;\
git clone http://192.168.81.8:10080/andylii/ceph-cluster-setup-helpers.git
