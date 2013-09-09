#
# Cookbook Name:: plexapp
# Recipe:: server
#
# Author:: Joshua Timberman <cookbooks@housepub.org>
# Copyright:: (c) 2012, Joshua Timberman
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

# TODO: support OS X and MS Windows

remote_file "#{Chef::Config[:file_cache_path]}/plexmediaserver_#{node['plexapp']['server']['version']}_#{node['plexapp']['package_arch']}.#{node['plexapp']['package_type']}" do
  source node['plexapp']['server']['package_url']
  checksum node['plexapp']['server']['package_checksum']
end

case node['platform']
when 'debian', 'ubuntu'
  [ "avahi-daemon", "avahi-utils" ].each do |pkg|
    package pkg
  end
  package "plexmediaserver_#{node['plexapp']['server']['version']}" do
    source "#{Chef::Config[:file_cache_path]}/plexmediaserver_#{node['plexapp']['server']['version']}_#{node['plexapp']['package_arch']}.#{node['plexapp']['package_type']}"
    provider Chef::Provider::Package::Dpkg
  end
when 'fedora', 'rhel', 'suse'
  package "plexmediaserver_#{node['plexapp']['server']['version']}" do
    source "#{Chef::Config[:file_cache_path]}/plexmediaserver_#{node['plexapp']['server']['version']}_#{node['plexapp']['package_arch']}.#{node['plexapp']['package_type']}"
    provider Chef::Provider::Package::Rpm
  end
end

service "plexmediaserver" do
  action [:enable, :start]
end
