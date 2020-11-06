#### This is a Dockerfile for setup docker container that has commonlisp development and photon runnnable environment.
####

### Base image ------------------------
FROM debian:buster as photon-base

MAINTAINER tomabu

RUN apt update && apt install -y libev-dev build-essential libcurl4-gnutls-dev autoconf git wget unzip
RUN wget https://github.com/roswell/roswell/archive/master.zip && unzip master.zip
RUN cd roswell-master && ./bootstrap && ./configure && make && make install && ros setup

### Initialize environment -------------
FROM photon-base as photon-env

RUN ros install dbym4820/photon
RUN cp $HOME/.roswell/bin/photon /opt/
RUN /opt/photon init
ADD ./user-ontology.xml /opt/user-ontology.xml


### Execution -------------
FROM photon-env as photon-runner

ADD ./user-ontology.xml /opt/user-ontology.xml
RUN /opt/photon local /opt/user-ontology.xml
CMD ["/opt/photon", "start-server"]

EXPOSE 5050

