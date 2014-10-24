FROM ubuntu:14.04.1
MAINTAINER Lukasz Wozniak

# get dependencies
RUN apt-get update -q
RUN apt-get upgrade -qy
RUN apt-get install -qy build-essential supervisor unzip

# prepare folders
RUN mkdir -p /opt/consul/conf && mkdir -p /opt/consul/logs && mkdir -p /opt/consul/data
WORKDIR /opt/consul

# get consul
ADD https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD https://dl.bintray.com/mitchellh/consul/0.4.1_web_ui.zip /tmp/webui.zip
RUN cd /tmp && unzip /tmp/webui.zip && mv dist /opt/consul/ui && rm /tmp/webui.zip

# configure consul
ADD /supervisord-consul.conf /etc/supervisor/conf.d/supervisord-consul.conf
ADD /50-defaults.json /opt/consul/conf/50-defaults.json

# Cleanup test
RUN apt-get -qq clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose volume for additional serf config in JSON
VOLUME /opt/consul/conf
VOLUME /opt/consul/logs
VOLUME /opt/consul/data

ENV CLUSTER_SIZE 1
ENV CONSUL_OPTS ""

EXPOSE 8301 8302 8300 8500 53
CMD ["supervisord", "-n"]