#
# Cookbook Name:: pdns
# Recipe:: default
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt::default"
package "dnsutils"
package "syslog-ng"

directory "/etc/powerdns"
directory "/etc/powerdns/pdns.d"

apt_repository "percona" do
  uri "http://repo.percona.com/apt"
  distribution "trusty"
  components ["main"]
  deb_src true
  keyserver "keys.gnupg.net"
  key "1C4CBDCDCD2EFD2A"
end
