
# vagrant-apt-cacher


## Introduction

If you're looking for the fastest possible Ubuntu deploys, you'll need this and http://schof.org/2014/01/10/putting-my-virtualbox-vagrant-virtual-machines-on-a-ramdisk/ . I suggest following the steps in this readme first, as you'll want the apt-cacher VM on your local drive, not the ramdisk.

Please note (due to a limitation in apt-cacher) that this will only work with ONE apt-based OS. So you can use it with Ubuntu Trusty and Ubuntu Precise, but you can't use it with Ubuntu anything and Debian anything.


## Installation

### Pre-Requisites

You'll need [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed.

### Caching Server Setup

```
cd [WHERE YOU KEEP CODE]
git clone https://github.com/johnmarkschofield/vagrant-apt-cacher.git
cd vagrant-apt-cacher
vagrant up
# The Vagrant VM may shut down. If it does, run "vagrant up" again. Any time you reboot your computer, switch to this directory and run "vagrant up".
```


### How to Configure Your Other Vagrant Virtual Machines

Here's an example Vagrantfile for a VM that uses the cache. Each Vagrantfile you create on the same host box will need a different static IP.

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$proxyconfig = <<SCRIPT
echo 'Acquire::http::Proxy "http://10.5.5.5:3142";' > /etc/apt/apt.conf.d/01proxy
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "10.5.5.10"

  config.vm.provision "shell", inline: $proxyconfig

  # If you're using vagrant-vbguest to keep your virtualbox additions up-to-date, you can uncomment this line,
  # then provision this VM, then comment the line out so virtualbox-vbguest runs and uses the cache.
  #config.vbguest.auto_update = false

end
```