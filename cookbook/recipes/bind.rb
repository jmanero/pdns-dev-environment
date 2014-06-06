#
# Cookbook Name:: pdns
# Recipe:: bind
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
# Base installation of BIND9
#
package "bind9"
service "bind9" do
  action :nothing
end

execute "RNDC-Reconfig" do
  action :nothing
  command "rndc reconfig"
end

execute "RNDC-Reload" do
  action :nothing
  command "rndc reload example.com"
end

log "Notify BIND9 Service Start" do
  notifies :start, "service[bind9]"
  notifies :enable, "service[bind9]"
end
