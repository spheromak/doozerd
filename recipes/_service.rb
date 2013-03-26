#
#
# Cookbook:: doozerd
# Recipe:: _service
#
# Manage the Doozerd service
#



template "/etc/init.d/doozerd" do
  mode 0755
end
