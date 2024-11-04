# Inception
In this project various services can be set up with Docker in a virtual machine. The services are described below.

## Overview
According to the subject, each service should be built either from the penultimate stable version of Alpine or Debian. I chose Alpine:3.19 as the base image for a significantly smaller footprint and faster builds. Dockerfile should be written, one per service, without pulling ready-made Docker images. 

Mandatory setup:
- Nginx with TLSv1.3
- WordPress + php-fpm
- MariaDB
- a volume containing the WordPress database
- a volume containing the WordPress website files
- a docker network that establishes the connection between the containers
- a domain name (ixu.42.fr) pointing to local IP address (💡 modify the /etc/hosts file in the VM)

Bonus setup:
- redis cache for the WordPress website to manage the cache
- a FTP server container pointing to the volume of the WordPress website. I used Pure-FTPd
- a simple static website, can be accessed in the VM at http://ixu.42.fr:8080
- Adminer, can be accessed in the VM at http://ixu.42.fr:8081
- Netdata, can be accessed in the VM at http://ixu.42.fr:8082

The WordPress website can be accessed in the VM at https://ixu.42.fr
 
For security reasons, all the credentials should be saved locally in srcs/.env file and ignored by git. This file was uploaded on GitHub for illustrative purpose only.

## Usage
- run `git clone https://github.com/ixu42/inception.git`
- run `cd inception`
- run `make up` to build the images and run the containers in the background. Please wait until WordPress is fully set up (run `make logs` to check logs of different services)
- run `make down` to stop and remove these containers
- run `make ps` to list the containers with current status and exposed ports
