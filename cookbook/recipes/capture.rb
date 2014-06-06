#
# Cookbook Name:: pdns
# Recipe:: default
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
include_recipe "pdns::default"
package "ubuntu-desktop"
package "wireshark"
