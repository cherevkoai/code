#!/bin/bash

sudo apt-get update -y

#sudo apt-get install -y htop
#sudo apt-get install -y net-tools
#sudp apt-get install -y nmap

#sudo apt-get install -y python3 python3-pip

#Install Docker
#sudo apt-get install docker-ce docker-ce-cli containerd.io

#Install Postgresql
#sudo apt install -y postgresql postgresql-contrib
#sudo -i -u postgres переключение на учетную запись postgres
#psql доступ к командной строке postgres

#Install Jenkins
#sudo apt install -y openjdk-8-jdk
#wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
#sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > \
#    /etc/apt/sources.list.d/jenkins.list'
#sudo apt-get update -y
#sudo apt-get install -y jenkins

sudo apt-get upgrade -y