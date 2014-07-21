#!/bin/bash

apt-get update

apt-get install -y update-notifier-common

# Preseed apt-cache settings
cat <<EOF | debconf-set-selections
apt-cacher	apt-cacher/mode	select	daemon
EOF

apt-get install -y apt-cacher apache2
grep -q "^allowed_hosts" /etc/apt-cacher/apt-cacher.conf || echo "allowed_hosts = *" >> /etc/apt-cacher/apt-cacher.conf

service apt-cacher restart
service apache2 restart

echo 'Acquire::http::Proxy "http://10.5.5.5:3142";' > /etc/apt/apt.conf.d/01proxy

apt-get install -y update-notifier-common
apt-get dist-upgrade -y
apt-get autoremove -y

if [ -e /var/run/reboot-required ]; then
	echo "Shutting down... Wait a moment, then run 'vagrant up'."
	shutdown -h now
fi
