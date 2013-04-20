#
#
# Cookbook:: doozerd
# Recipe:: _service
#
# Manage the Doozerd service
#


template "#{node[:doozerd][:init_path]}/doozerd" do
  notifies :restart, "service[doozerd]"
  source "doozer_init.erb"
  mode 0755
  # for now use the attribute, some wrapper could use search/discovery 
  # and probably should.
  variables( 
    :doozer_nodes => node[:doozerd][:nodes],
    :doozer_host  => node[:doozerd][:host],
    :doozer_port  => node[:doozerd][:port]
  )
end


service "doozerd" do 
  action :start
end


