#
# Cookbook Name:: pdns
# Recipe:: pdns
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
include_recipe "pdns::default"

## Percona Server 5.6
package "percona-server-server-5.6"

## Install Schema
execute "PDNS-Database-Provision" do
  command "mysql -u root < /etc/powerdns/schema.sql"
  action :nothing
end

template "/etc/powerdns/schema.sql" do
  source "database.sql.erb"
  backup false
  notifies :run, "execute[PDNS-Database-Provision]"
end
