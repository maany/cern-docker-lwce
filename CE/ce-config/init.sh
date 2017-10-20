#!/bin/bash

#check ce-config directory structure
#TODO

#copy host certificates
echo "Copying host certificates..."
cp /ce-config/host-certificates/hostcert.pem /etc/grid-security/
cp /ce-config/host-certificates/hostkey.pem /etc/grid-security/

#set permissions
echo "Setting permissions for host certificates..."
chmod 600 /etc/grid-security/hostkey.pem
chmod 644 /etc/grid-security/hostcert.pem

#run YAIM
echo "Starting YAIM..."
/opt/glite/yaim/bin/yaim -c \
	-s /ce-config/CE/cream-info.def \
	-n creamCE \
	-n TORQUE_server \
	-n TORQUE_util



