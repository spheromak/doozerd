#
#
# Cookbook:: doozerd
# Recipe:: server
#
#

# for now just do binary install
include_recipe "doozerd::binary"
include_recipe "doozerd::_service"




