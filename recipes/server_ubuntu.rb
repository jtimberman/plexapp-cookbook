#
# Cookbook Name:: plexapp
# Recipe:: server_ubuntu
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

apt_repository "plexapp" do
  uri "http://plexapp.com/repo"
  distribution "lucid"
  components ["main"]
  action :add
end

package "plex-archive-keyring" do
  options "--force-yes"
  action :install
  notifies :run, "execute[apt-get update]", :immediately
end

package "plexmediaserver"

service "plexmediaserver" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end
