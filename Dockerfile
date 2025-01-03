ARG OSVERSION=9

FROM almalinux:$OSVERSION
ARG OSVERSION

## TODO: Versioning..
LABEL version=0.0.0.0
LABEL description="Nomad External IP Helper service"
LABEL maintainer="pablo.ruiz@gmail.com"
LABEL vendor="Pablo Ruiz"

WORKDIR /

# Install base stuff..

RUN yum -y install openssl ca-certificates epel-release
## Install core stuff (vault, nomad, terraform, etc.)
RUN yum -y install microdnf \
    git dos2unix which jq vim-enhanced unzip lsb-release \
    python3 python3-pip python3-setuptools python3-requests \
    iptables-legacy iptables

RUN pip install python-nomad

## Use iptables-legacy by default..
RUN alternatives --set iptables /usr/sbin/iptables-legacy

## Install dockerize..
ARG DOCKERIZE_VERSION=0.6.1
RUN curl -LO https://github.com/jwilder/dockerize/releases/download/v$DOCKERIZE_VERSION/dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz

RUN yum --enablerepo=\* clean all

ADD files/nomad-extip-manager.py /usr/local/bin/
#ADD files/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/bin/python3", "/usr/local/bin/nomad-extip-manager.py"]
