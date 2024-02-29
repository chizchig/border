#!/bin/bash

# Install Java
sudo yum install -y java-1.8.0-openjdk-devel

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins
