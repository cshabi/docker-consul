stlhrt/consul
=========================
Docker base container for main [_Consul_](http://www.consul.io/) on Ubuntu Trusty Tahr.

Exposes volume for _Consul_ configuration files in /opt/consul/conf

Default configuration is provided in 50-defaults.json but can be overriden, just mount a directory with *.json files there and Consul will load them.