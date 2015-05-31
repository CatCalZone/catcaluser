# Dockerfile für catcal.user service based on the Elixir Phoenix Framework
# It is based on phusion/baseimage and the Elixir dockerfile from Nizar Venturini @trenpixster
FROM phusion/baseimage
MAINTAINER Klaus Alfert <kal@zuehlke.com>

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Baseimage-docker enables an SSH server by default, so that you can use SSH
# to administer your container. In case you do not want to enable SSH, here's
# how you can disable it. Uncomment the following:
#RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update -y
# Install postgres client libraries
RUN apt-get install postgresql-client-9.3 -y

# Set the environemnt variables for the catcal user
# via INIT
RUN mkdir -p /etc/container_environment
RUN echo en_US.UTF-8 > /etc/container_environment/LANG
RUN echo en_US.UTF-8 > /etc/container_environment/LANGUAGE
RUN echo en_US.UTF-8 > /etc/container_environment/LC_ALL



# where is the application file living?
# which ports to be used?
EXPOSE 4001

# create a non-root user
RUN groupadd -r catcal && useradd -r -g catcal catcal -d /catcaluser

# install the catcaluser tar file 
# run docker build from the project's main directory!
ADD catcaluser.tar.gz /
RUN mkdir -p /catcaluser
RUN cd /catcaluser && tar zxf /catcaluser.tar.gz
RUN chown -R catcal /catcaluser

RUN mkdir /etc/service/catcaluser
ADD catcaluser_run.sh /etc/service/catcaluser/run
RUN ls -al /etc/container_environment

# USER catcal

RUN ls -l catcal* 
RUN env | sort


# Then run the generated start-script
WORKDIR /catcaluser

