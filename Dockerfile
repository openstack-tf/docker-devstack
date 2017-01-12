FROM ubuntu:16.04
MAINTAINER Anson
ENV LANG C.UTF-8

RUN mkdir /root/.pip

ADD sources.list /etc/apt/sources.list
ADD pip.conf /root/.pip/pip.conf

RUN apt update && apt install -y software-properties-common && add-apt-repository cloud-archive:newton && \
  apt dist-upgrade -y && apt install -y vim iputils-ping net-tools git ssh\
  tmux lrzsz python-pip python-tox uwsgi python-dev libffi-dev libssl-dev libxml2-dev \
  libxslt1-dev libjpeg8-dev zlib1g-dev iptables && pip install -U os-testr && \
  cd /home && git clone http://git.trystack.cn/openstack-dev/devstack -b stable/newton && \
  ./devstack/tools/create-stack-user.sh && chown -R stack:stack /home/devstack && \
  mv /bin/systemctl /bin/systemctl-bak

ADD local.conf /home/devstack/local.conf


CMD ["/bin/bash"]
