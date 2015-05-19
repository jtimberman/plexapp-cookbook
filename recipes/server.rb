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
cached_package_file = File.join(
                                Chef::Config[:file_cache_path],
                                plexapp_package_file(plexapp_package_url)
                               )

remote_file cached_package_file do
  source plexapp_package_url
end

package [ 'avahi-daemon', 'avahi-utils' ] if platform_family?('debian')

package 'plexmediaserver' do
  source cached_package_file
end

service 'plexmediaserver' do
  action [:enable, :start]
end
