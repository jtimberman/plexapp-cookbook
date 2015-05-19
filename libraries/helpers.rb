#
# Cookbook: plexapp
# Libraries: helpers
#
# Author:: Joshua Timberman <cookbooks@housepub.org>
# Copyright:: (c) 2015, Joshua Timberman
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
require 'pathname'
require 'uri'

module PlexAppCookbook
  module Helpers
    def plexapp_package_file(uri)
      Pathname.new(URI.parse(uri).path).basename.to_s
    end

    def plexapp_package_url
      # This method will construct the URL for the package to download
      # like these:
      # - https://downloads.plex.tv/plex-media-server/0.9.12.1.1079-b655370/plexmediaserver_0.9.12.1.1079-b655370_amd64.deb
      # - https://downloads.plex.tv/plex-media-server/0.9.12.1.1079-b655370/plexmediaserver-0.9.12.1.1079-b655370.x86_64.rpm
      # - https://downloads.plex.tv/plex-media-server/0.9.12.1.1079-b655370/plexmediaserver-0.9.12.1.1079-b655370.x86_64.rpm
      # - https://downloads.plex.tv/plex-media-server/0.9.12.1.1079-b655370/PlexMediaServer-0.9.12.1.1079-b655370-freebsd-amd64.tar.bz2
      # - https://downloads.plex.tv/plex-media-server/0.9.12.1.1079-b655370/PlexMediaServer-0.9.12.1.1079-b655370-OSX.zip
      #
      # Unfortunately they're all slightly different, so we try to do
      # what we can to automatically construct the URI based on the
      # platform.
      #
      return node['plexapp']['url'] if node['plexapp']['url']
      plex_url = 'https://downloads.plex.tv'
      plex_url << '/plex-media-server/'
      plex_url << node['plexapp']['version']
      # ternary operators inside your interpolated string: everything is just fine.
      plex_url << "/#{plexapp_file_name}#{platform_family?('debian') ? '_' : '-'}"
      plex_url << node['plexapp']['version']
      plex_url << plexapp_file_ext
      return plex_url.to_s
    end

    def plexapp_file_ext
      case node['platform_family']
      when 'rhel', 'fedora' then '.x86_64.rpm'
      when 'debian'         then '_amd64.deb'
      when 'mac_os_x'       then '-OSX.zip'
      when 'freebsd'        then '-freebsd-amd64.tar.bz2'
      end
    end

    # If we supported windows, it would be `Plex-Media-Server`...
    def plexapp_file_name
      case node['os']
      when 'freebsd', 'darwin' then 'PlexMediaServer'
      when 'linux'             then 'plexmediaserver'
      end
    end
  end
end

Chef::Recipe.send(:include, PlexAppCookbook::Helpers)
Chef::Resource::RemoteFile.send(:include, PlexAppCookbook::Helpers)
