FROM 192.168.1.105:5000/ubuntu:16.04
MAINTAINER Anson "tangkaigen@tongfangcloud.com"
ENV LANG C.UTF-8

ADD sources.list /etc/apt/sources.list
ADD pip.conf /root/.pip/pip.conf

RUN apt update && apt install -y software-properties-common && add-apt-repository cloud-archive:newton && \
  apt dist-upgrade -y && apt install -y vim iputils-ping net-tools git ssh jq \
  tmux lrzsz python-pip python-tox uwsgi python-dev libffi-dev libssl-dev libxml2-dev \
  libxslt1-dev libjpeg8-dev zlib1g-dev iptables && pip install -U os-testr && \
  cd /home && git clone http://git.trystack.cn/openstack-dev/devstack -b stable/newton && \
  mv /bin/systemctl /bin/systemctl-bak && ./devstack/tools/create-stack-user.sh

ADD devstack/* /home/devstack/
ADD devstack/lib/databases/mysql /home/devstack/lib/databases/mysql
ADD test-device /opt/stack/test-device

RUN chown -R stack:stack /home/devstack /opt/stack/* 
USER stack 
RUN cd /home/devstack && ./stack.sh && ./unstack.sh

CMD ["/bin/bash"]
