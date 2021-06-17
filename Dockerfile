#### This is a Dockerfile for setup docker container that has commonlisp development and photon runnnable environment.
####

### Base image ------------------------
FROM debian:buster as photon-base

MAINTAINER tomabu

RUN apt update && apt install -y libev-dev build-essential libcurl4-gnutls-dev autoconf git wget unzip
RUN wget https://github.com/roswell/roswell/archive/master.zip && unzip master.zip
RUN cd roswell-master && ./bootstrap && ./configure && make && make install && ros install sbcl-bin/2.0.5

### Initialize environment -------------
FROM photon-base as photon-env

RUN PATH=$PATH:$HOME/.roswell/bin
RUN cd /opt/ && git clone https://github.com/dbym4820/photon.git
RUN ros install qlot && cd /opt/photon && $HOME/.roswell/bin/qlot install
RUN ln -nfs /opt/photon $HOME/.roswell/local-projects/photon
RUN ros /opt/photon/roswell/photon.ros init
ADD ./user-ontology.xml /opt/user-ontology.xml


# ### Execution -------------
# FROM photon-env as photon-runner

# ADD ./user-ontology.xml /opt/user-ontology.xml
RUN ros /opt/photon/roswell/photon.ros local /opt/user-ontology.xml
#CMD ["$HOME/.roswell/bin/qlot" "exec" "ros" "/opt/photon/roswell/photon.ros", "start-server"]
RUN cd /opt/photon/roswell/ && ros build /opt/photon/roswell/photon.ros
CMD ["/opt/photon/roswell/photon", "start-server"]

EXPOSE 5050

