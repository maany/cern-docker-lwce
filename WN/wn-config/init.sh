#!/bin/bash

# move configuration files to the correct place
echo "Copying configuraiton files..."
cp /etc/opt/wn-config/wn-info.def /root/
cp /etc/opt/wn-config/users.conf /root/
cp /etc/opt/wn-config/groups.conf /root/
cp /etc/opt/wn-config/wn-list.conf /root/

# run YAIM
echo "Starting YAIM..."
/opt/glite/yaim/bin/yaim -c \
	-s /wn-config/wn-info.def \
	-n WN \
	-n TORQUE_client
