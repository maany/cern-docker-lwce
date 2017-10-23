# Introduction

This folder contains the code and resources required to 
 - build a docker image for a creamCE compute element
 - run a container hosting the creamCE compute element
 
The following sections describe how to get docker image for creamCE and start a container with it.

# Pre-requisites

## host-certificates
You need get host-certificates for your grid site from a [IGTF](https://www.igtf.net) trusted CA.
You might have to convert the host certficate into a keypair (**hostkey.pem** and **hostcert.pem**). Please follow the instructions [here](https://ca.cern.ch/ca/Help/?kbid=024100) and make sure you have set up the appropriate permissions for your hostkey.pem
## docker
You need to have docker installed on the machine where you want to setup creamCE using containers
You can go through the Get Docker section on the [Docker](https://www.docker.com) website to set it up depending on your host platform.
For CentOS7, the following snippet will setup docker on your machine:
~~~
# install required packages
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
# add stable repo
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
# Install docker-ce
sudo yum install docker-ce

# Start docker daemon
sudo systemctl start docker

# Verify installation by running a hello world container. See the output to see if the installation was a success.
sudo docker run hello-world
~~~
# Additional Files and Folders
After you have cloned this repository locally, you need to add the following directories:
 - cern-docker-lwce/CE/host-certificates
 
You can use the following snippet:
~~~
git clone https://github.com/maany/cern-docker-lwce
cd cern-docker-lwce
mkdir ./CE/host-certificates
~~~

Next, 
 - Copy your **hostkey.pem** and **hostcert.pem** inside host-certificates directory you've just created.
 - Provide the YAIM configurations through the following files:
   - cream-info.def : main configuration file for **YAIM** 
   - users.conf
   - groups.conf
   - wn-list.conf : list the fully qualified domain name of the worker codes
   - edgusers.conf

Please note that the final direcrory structure should look like:
```
.
├── CE
│   ├── ce-config
│   │   ├── CE
│   │   │   ├── cream-info.def
│   │   │   ├── edgusers.conf
│   │   │   ├── groups.conf
│   │   │   ├── users.conf
│   │   │   └── wn-list.conf
│   │   ├── host-certificates
│   │   │   ├── hostcert.pem
│   │   │   └── hostkey.pem
│   │   └── init.sh
│   └── Dockerfile
├── CE-baked
│   ├── docker-compose.yml
│   └── Dockerfile
└── README.md
```
# Get the Docker Image 
 
 You can either download the docker image directly from [Docker Hub](https://hub.docker.com/r/maany/lightweight-site-ce/) or you can build the image on your machine using the Dockerfile included in the source code.
 
 ## Download Docker Image
 
` docker pull maany/lightweight-site-ce` 
 
 ## Build docker image
 If you want to build the docker image locally, you can build one from the Dockerfile included in the source code.
  - cd into the directory /cern-docker-ce/CE
  - build a docker image using
  `docker build -t lwce .`
  
# Start a container
 
```
# please be sure to specify the placeholder {location_of_cern_docker_lwce}
sudo docker run -d -it --name=mountest --mount type=bind,source={location_of_cern_docker_lwce}/CE/ce-config,target=/ce-config lwce /bin/bash

```

# Some Helpful commands
~~~
# see all containers
docker ps -a
# open shell on running container
docker exec -it {name_of_the_conatiner} /bin/bash
~~~
