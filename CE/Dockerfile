
FROM cern/slc6-base
MAINTAINER Mayank Sharma (mayank.sharma@cern.ch)
########################
#   Misc packages
########################

#install sudo and wget
RUN yum install -y \
	sudo \
	wget

########################
#        UMD 3
########################

# install yum-priorities
RUN yum install -y \
	yum-priorities

# Install (for now) the SL6 repo details for UMD-3, because currently it has
# most of the necessary components:
RUN yum install -y \
	http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.4-1.el6.noarch.rpm

#########################
#    Torque + Maui
#########################

#Torque + Maui are most easily obtained from the EGI third-party repository
RUN wget -O /etc/yum.repos.d/EGI-third-party.repo \
	http://repository.egi.eu/community/software/third.party.distribution/1.0/releases/repofiles/sl-6-x86_64.repo

#Let it override the unsupported Torque from EPEL:

RUN echo -e 'protect=1\npriority=1' >> /etc/yum.repos.d/EGI-third-party.repo 

#The third-party repo Torque version looks old, but all known serious
#vulnerabilities have been patched by experts in EGI.

#Maui is no longer officially supported by anyone AFAIK, but as long as the
#firewall configurations limit the access as advertised, we need not be too
#concerned about that.

#########################
#     Configuration
#########################

RUN yum -y install lcg-CA \
	emi-cream-ce \
	emi-torque-server \
	emi-torque-utils


# for compatibility between different versions...

RUN ln -s /var/spool/pbs /var/lib/torque
RUN mkdir /var/spool/pbs/checkpoint

# work around an old bug...
RUN perl -pi.bak -e 's/while.*]/for i in `seq 10`/' /etc/init.d/pbs_server

# Mount Volume for configuration parameters
VOLUME /ce-config

# init script on launch
# TODO script should be packaged within the image, using on mount point only for development purposes
ENTRYPOINT ["/ce-config/init.sh"]


