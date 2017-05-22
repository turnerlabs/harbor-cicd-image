FROM ubuntu:16.04

# convenient aliases
RUN echo "alias dc=docker-compose" >> ~/.bashrc && \
    echo "alias hc=harbor-compose" >> ~/.bashrc

# install docker
ENV DOCKER_VERSION 17.03.0

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && \
    apt-get install -y docker-ce=${DOCKER_VERSION}~ce-0~ubuntu-xenial

# install docker-compose
ENV DC_VERSION 1.12.0

RUN curl -L https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# jq
RUN apt-get install -y jq

# install harbor-compose
ENV HC_VERSION v0.11.0-pre-4-gbafb6f2

RUN curl -sSLo /usr/local/bin/harbor-compose https://github.com/turnerlabs/harbor-compose/releases/download/${HC_VERSION}/ncd_linux_amd64 && chmod +x /usr/local/bin/harbor-compose

CMD ["/bin/bash"]