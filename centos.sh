#!/bin/bash

sudo yum update

sudo yum install -y nano
sudo yum install -y git
sudo yum install -y htop
sudo yum install -y mc
sudo yum install -y net-tools
sudo yum install -y bind-utils

git clone https://github.com/cherevkoai/code.git

sudo yum install -y pytho3 python3-pip

#Install Docker-Ce
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker -y

#Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel
sudo systemctl daemon-reload

#Install Postgres 9.2
Dowland PostgreSQL 9.2
sudo yum install postgresql postgresql-server
sudo postgresql-setup initdb
sudo systemctl enable postgresql && systemctl start postgresql

#sudo yum upgrade
