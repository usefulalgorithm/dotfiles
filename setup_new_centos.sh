#!/bin/bash
yum install -y sudo epel-release bash-completion vim net-tools wget sysstat git lshw gcc gcc-g++ libstdc++-devel
# yum install scl-utils centos-release-scl devtoolset-7 boost;\
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
echo "source ~/.git-prompt.sh" >> ~/.bashrc
echo "PS1='\u@\$PNAME [\[\e[1;31m\]\$(__git_ps1 \" %s\")\[\e[0m\] \[\e[32m\]\$PWD\[\e[0m\] ]\n$ '" >> ~/.bashrc
yum install -y htop
git config --global color.ui auto
# scl enable devtoolset-7 bash ;\
# echo "source scl_source enable devtoolset-7" >> ~/.bashrc ;\

# Add keys
sudo rpm --import 'https://download.ceph.com/keys/release.asc'

# Add Ceph
cat <<EOT >> /etc/yum.repos.d/ceph.repo
[ceph]
name=Ceph packages for \$basearch
baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/\$basearch
enabled=1
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-noarch]
name=Ceph noarch packages
baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/noarch
enabled=1
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-source]
name=Ceph source packages
baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/SRPMS
enabled=0
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc
EOT
sed -i "s/{ceph-release}/$version/g" /etc/yum.repos.d/ceph.repo ;\
sed -i 's/{distro}/el7/g' /etc/yum.repos.d/ceph.repo ;\
sed -i 's/noarch/x86_64/g' /etc/yum.repos.d/ceph.repo

# Additional packages
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Get Ceph
sudo yum install -y ceph

# Change shell for user "ceph"
chsh -s /bin/bash ceph

cd /root/
wget https://raw.githubusercontent.com/usefulalgorithm/dotfiles/master/vimrc
mv vimrc ~/.vimrc
git clone http://192.168.81.8:10080/andylii/ceph-cluster-setup-helpers.git
