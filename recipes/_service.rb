#
#
# Cookbook:: doozerd
# Recipe:: _service
#
# Manage the Doozerd service
#
#

# nodes in the cluster. should assemble this with discover or somehting else
# for now use attribs
attach_args = ""
unless node[:doozerd][:nodes].empty? 
  attach_args = "-a " + node[:doozerd][:nodes].join("-a ")
end

# if we have a cluster boot uri use it in the init
if node[:doozerd][:boot_uri] 
  boot_uri = "-b #{node[:doozerd][:boot_uri]}"
end

if node[:doozerd][:use_upstart] == true
  template "/etc/init/doozerd.conf" do
    source "upstart.erb"
    variables(
      :boot_uri       => boot_uri,
      :attach_address => attach_args,
      :cluster_name   => node[:doozerd][:cluster_name],
      :listen_address => "#{node[:doozerd][:bind]}:#{node[:doozerd][:port]}"
    )
  end

  service "doozerd" do 
    action :nothing
    provider Chef::Provider::Service::Upstart
  end
end


service "doozerd" do 
  action :start
end


