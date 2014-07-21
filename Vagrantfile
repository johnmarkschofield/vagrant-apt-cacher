# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "10.5.5.5"
  config.vm.network "forwarded_port", guest: 3142, host: 3142
  config.vm.provision "shell", path: "setup.bash"
  config.vm.hostname = "ubuntu-trusty-apt-cacher"

  # If you're using vagrant-vbguest to keep your virtualbox additions up-to-date, you can uncomment this line,
  # then provision this VM, then comment the line out so virtualbox-vbguest runs and uses the cache.
  config.vbguest.auto_update = false

end
