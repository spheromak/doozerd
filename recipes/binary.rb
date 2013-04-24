# 
# Cookbook:: Doozerd
# Recipe:: binary_install
#
#  Pulls down precompiled binary of doozer and places it.
#  
#
#  This is a quick hack recipe and is intended to be replaced by a proper package recipe.
#  


# TODO: these methods should be in libs
def doozer_uri(app)
  case node[:os] 
  when "linux" 
    os = "linux"
    arch = node[:kernel][:machine]
    uri = "#{node[app][:bin_uri]}-#{os}-#{arch}-#{node[:doozerd][:version]}"
  else 
    raise AttributeError, "Unsupported platform for doozerd binary install"
  end
  uri
end

def doozer_bin(app)
  "#{node[app][:prefix]}/#{app}"
end

def doozer_sum(app)
  node[app][:md5sum]
end

%w/doozerd doozer/.each do |app| 
  # do this here so we don't have to polute the rsources with our methods
  uri = doozer_uri(app)
  bin = doozer_bin(app)
  sum = doozer_sum(app)

  Chef::Log.debug "computed doozer values:\nuri: #{uri}\nbin: #{bin}\nsum: #{sum}"
  remote_file bin do
    action :nothing
    source uri
    mode 0755
    backup false
    checksum sum
  end

  http_request "HEAD " + uri do
    message ""
    url uri
    action :head
    if File.exists?( bin )
      headers "If-Modified-Since" => File.mtime(bin).httpdate
    end
    notifies :create, "remote_file[#{bin}]", :immediately
  end
end
