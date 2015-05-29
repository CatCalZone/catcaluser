# Dockerfile für catcal.user service based on the Elixir Phoenix Framework
#
FROM phusion/baseimage
MAINTAINER Klaus Alfert <kal@zuehlke.com>
RUN apt-get update -y


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
USER catcal

ENV LANG de_DE.UTF-8
ENV HOME /catcaluser

RUN ls -l catcal* 
RUN env | sort

# Then run the generated start-script
WORKDIR /catcaluser
ENTRYPOINT ["/catcaluser/bin/catcaluser"]
