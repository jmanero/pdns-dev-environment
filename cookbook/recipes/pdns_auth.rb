#
# Cookbook Name:: pdns
# Recipe:: pdns
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
include_recipe "pdns::default"
include_recipe "pdns::database"

## Installation Method package
if node["pdns"]["install"] == "package"
  package "pdns-server"
  package "pdns-backend-mysql"
end

## Installation Method source
include_recipe "pdns::build" if node["pdns"]["install"] == "source"

## Upstart
file "/etc/init.d/pdns" do
  backup false
  action :delete
end

template "/etc/init/pdns.conf" do
  source "pdns.upstart.erb"
  backup false
end

## Service
service "pdns" do
  action :nothing
  provider Chef::Provider::Service::Upstart
end

log "Notify pdns Service Start" do
  notifies :start, "service[pdns]"
  notifies :enable, "service[pdns]"
end

## Configuration
template "/etc/powerdns/pdns.conf" do
  source "pdns.conf.erb"
  backup false
  notifies :restart, "service[pdns]"
end

file "/etc/powerdns/pdns.d/pdns.simplebind.conf" do
  action :delete
  backup false
  notifies :restart, "service[pdns]"
end

template "/etc/powerdns/pdns.d/pdns.local.gmysql.conf" do
  source "gmysql.pdns.conf.erb"
  backup false
  notifies :restart, "service[pdns]"
end
