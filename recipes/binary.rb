# 
# Cookbook:: Doozerd
# Recipe:: binary_install
#
#  Pulls down precompiled binary of doozer and places it.
#  
#
#  This is a quick hack recipe and is intended to be replaced by a proper package recipe.
#  

doozerd_bin = node[:doozerd][:bin_path] + "/doozerd"

case node[:os] 
when "linux" 
  os = "linux"
  arch = node[:kernel][:machine]
  bin_url = "#{node[:doozerd][:bin_uri]}-#{os}-#{arch}-#{node[:doozerd][:version]}"
else 
  raise AttributeError, "Unsupported platform for doozerd binary install"
end

remote_file doozerd_bin do
  action :nothing
  source bin_url
  mode 0755
  backup false
  checksum node[:doozerd][:md5sum]
end

http_request "HEAD #{bin_url}" do
  message ""
  url bin_url
  action :head
  if File.exists?(doozerd_bin)
    headers "If-Modified-Since" => File.mtime(doozerd_bin).httpdate
  end
  notifies :create, "remote_file[#{doozerd_bin}]", :immediately
end
