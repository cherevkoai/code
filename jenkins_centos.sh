#!/bin/bash

sudo yum update

#Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo -y
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key -y
sudo yum -y upgrade
sudo yum -y install jenkins java-1.8.0-openjdk-devel
sudo systemctl daemon-reload -y
