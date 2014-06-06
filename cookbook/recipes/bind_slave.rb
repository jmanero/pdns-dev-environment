#
# Cookbook Name:: pdns
# Recipe:: bind-master
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
# Configure BIND9 to be a test master
#
include_recipe "pdns::default"
include_recipe "pdns::bind"

template "/etc/bind/named.conf" do
  source "bind.slave.erb"
  backup false
  notifies :run, "execute[RNDC-Reconfig]"
end

template "/var/cache/bind/example.com.db" do
  source "example.zone.erb"
  backup false
  action :create_if_missing
  notifies :restart, "service[bind9]"
end
