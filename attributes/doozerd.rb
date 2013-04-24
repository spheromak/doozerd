default[:doozerd][:prefix] = "/usr/local/bin"
default[:doozerd][:bin_uri] = "http://dl.dropbox.com/u/848501/doozerd"
default[:doozerd][:version] = "04232013"
default[:doozerd][:md5sum] = "ab781827b471ecf4322cf06b7d80895e"


default[:doozerd][:bind]  = ipaddress
default[:doozerd][:port]  = "9200"

default[:doozerd][:nodes] = []
default[:doozerd][:boot_uri] = nil
default[:doozerd][:cluster_name] = "chef"

# for now just use upstart.
# is upstart default on ubuntu ?
case platform_family 
when "debian"
  if "ubuntu" == platform and platform_version.to_f >= 9.10
    default[:doozerd][:use_upstart] = true
  end
end



