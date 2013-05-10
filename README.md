# Overview

These are the Vagrant configs for a stadard development machine at (Cloudmanic Labs)[http://cloudmanic.com]. This install does the following things.

* Installs lighttpd
* Installs php 5.4
* Installs mysql
* Installs phpmyadmin
* Installs memcached
* Installs redis
* Installs beanstalkd
* Links /CloudmanicLabs/www-clients to /var/www
* Enables much needed lighttpd mods
* Enables modrewrite on *.dev domains. 

# Using just the puppet config portion. 

Maybe you do not want to run Vagrant. You can simple checkout this repo and run puppet from the command line.

```puppet apply --verbose --modulepath=modules/ manifests/init.pp``` 