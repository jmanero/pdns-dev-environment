#
# Cookbook Name:: pdns
# Recipe:: build
#
# Copyright (C) 2014 John Manero
#
# All rights reserved - Do Not Redistribute
#
# Base installation of BIND9
#
include_recipe "pdns::default"
node.default["pdns"]["bin"] = "/usr/local/sbin/pdns_server"

package "build-essential"
package "git"

# autoconf dependencies
package "autoconf"
package "libtool"
package "pkg-config"

# Build dependencies
package "flex"
package "bison"
package "libboost-all-dev"
package "libperconaserverclient18-dev"
package "libssl-dev"
package "ragel"

git "PDNS-Source-Repository" do
  destination node["pdns"]["source"]
  user node["pdns"]["builder"]
  group node["pdns"]["builder"]
  repository node["pdns"]["repository"]
  revision node["pdns"]["version"]
  action :sync
  only_if { node["pdns"].include?("repository") }
end

["libtoolize --force", "aclocal", "autoheader",
 "automake --force-missing --add-missing", "autoconf",
 "sh configure --with-modules=\"gmysql\" --without-lua",
 # "make -j4"
].each do |command|
  execute command do
    user node["pdns"]["builder"]
    group node["pdns"]["builder"]
    cwd node["pdns"]["source"]

    action node["pdns"].include?("repository") ? :nothing : :run
    subscribes :run, "git[PDNS-Source-Repository]" if node["pdns"].include?("repository")
  end
end
