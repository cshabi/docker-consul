stlhrt/consul
=========================

Docker base container for main [_Consul_](http://www.consul.io/) agent on Ubuntu Trusty Tahr in a cluster.

Exposes volume for _Consul_ configuration files in /opt/consul/conf

Default configuration is provided in 50-defaults.json but can be overriden, just mount a directory with *.json files there and Consul will load them.

Exposes all _Consul_ ports for all transports as well as WEB UI.