case node['kernel']['machine']
when 'x86_64'
  default['plexapp']['package_arch'] = 'x86_64'
when 'i686', 'i586', 'i386'
  default['plexapp']['package_arch'] = 'i686'
end

default['plexapp']['download_server'] = 'http://downloads.plexapp.com'
default['plexapp']['server']['install_method'] = 'direct_download'
default['plexapp']['server']['version'] = '0.9.8.6.175-88ffbb2'

# set this in node.json to make reloads impotent, e.g.
# cb32f546a68a6086dcba6d360e4cc482c6628c1fc4fe458bb54e564ad2187f22  plexmediaserver_0.9.8.6.175-88ffbb2_amd64.deb
default['plexapp']['server']['package_checksum'] = nil

case platform_family
when 'debian'
  default['plexapp']['package_type'] = 'deb'
  override['plexapp']['package_arch'] = 'amd64' if node['kernel']['machine'] = 'x86_64'
when 'fedora', 'rhel', 'suse'
  default['plexapp']['package_type'] = 'rpm'
end

default['plexapp']['server']['package_url'] = "#{node['plexapp']['download_server']}/plex-media-server/#{node['plexapp']['server']['version']}/plexmediaserver_#{node['plexapp']['server']['version']}_#{node['plexapp']['package_arch']}.#{node['plexapp']['package_type']}"