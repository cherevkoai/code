#!/bin/bash

sudo yum update -y

#sudo yum install -y nano
#sudo yum install -y git
#sudo yum install -y htop
#sudo yum install -y mc
#sudo yum install -y net-tools
#sudo yum install -y bind-utils
#sudo yum install -y wget

#git clone https://github.com/cherevkoai/code.git

#sudo yum install -y pytho3 python3-pip

#Install Docker-Ce
#sudo yum install -y yum-utils
#sudo yum-config-manager \
#    --add-repo \
#    https://download.docker.com/linux/centos/docker-ce.repo
#sudo yum-config-manager --enable docker-ce-test
#sudo yum-config-manager --disable docker-ce-nightly
#sudo yum install docker-ce docker-ce-cli containerd.io
#yum list docker-ce --showduplicates | sort -r
#sudo systemctl start docker

#Install Jenkins
#sudo wget -O /etc/yum.repos.d/jenkins.repo \
#    https://pkg.jenkins.io/redhat-stable/jenkins.repo
#sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#sudo yum -y upgrade
#sudo yum -y install jenkins java-1.8.0-openjdk-devel
#sudo systemctl start jenkins
#systemctl status jenkins
#sudo systemctl enable jenkins
#sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
#sudo firewall-cmd --reload

#Install Postgres 9.2
#sudo yum install postgresql postgresql-server
#sudo postgresql-setup initdb
#sudo systemctl enable postgresql && systemctl start postgresql
#Download Nginx Source

#Install Nginx CtntOS
#sudo yum install epel-release
#sudo yum install nginx
#service nginx start
#wget https://nginx.org/download/nginx-1.19.0.tar.gz
#tar zxf nginx-1.19.0.tar.gz
#cd nginx-1.19.0

sudo yum upgrade -y
