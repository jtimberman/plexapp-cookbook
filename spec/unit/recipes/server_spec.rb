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

require_relative '../spec_helper'

describe 'plexapp::server' do
  context 'ubuntu-14.04' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        file_cache_path: '/var/tmp/plexapp_chefspec'
      ) do |node|
        node.set['plexapp']['version'] = '42'
      end.converge(described_recipe)
    end

    it 'installs the avahi dependencies' do
      expect(chef_run).to install_package(['avahi-daemon', 'avahi-utils'])
    end

    it 'downloads the plexmediaserver package' do
      expect(chef_run).to create_remote_file(
        '/var/tmp/plexapp_chefspec/plexmediaserver_42_amd64.deb'
      ).with(
        source: 'https://downloads.plex.tv/plex-media-server/42/plexmediaserver_42_amd64.deb'
      )
    end

    it 'installs plexmediaserver with apt' do
      expect(chef_run).to install_apt_package('plexmediaserver').with(
        source: '/var/tmp/plexapp_chefspec/plexmediaserver_42_amd64.deb'
      )
    end

    it 'manages the plexmediaserver service' do
      expect(chef_run).to start_service('plexmediaserver')
      expect(chef_run).to enable_service('plexmediaserver')
    end
  end

  context 'fedora-21' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'fedora',
        version: '21',
        file_cache_path: '/var/tmp/plexapp_chefspec'
      ) do |node|
        node.set['plexapp']['version'] = '37'
      end.converge(described_recipe)
    end

    it 'downloads the plexmediaserver package' do
      expect(chef_run).to create_remote_file(
        '/var/tmp/plexapp_chefspec/plexmediaserver-37.x86_64.rpm'
      ).with(
        source: 'https://downloads.plex.tv/plex-media-server/37/plexmediaserver-37.x86_64.rpm'
      )
    end

    it 'installs plexmediaserver with yum' do
      expect(chef_run).to install_yum_package('plexmediaserver').with(
        source: '/var/tmp/plexapp_chefspec/plexmediaserver-37.x86_64.rpm'
      )
    end

    it 'manages the plexmediaserver service' do
      expect(chef_run).to start_service('plexmediaserver')
      expect(chef_run).to enable_service('plexmediaserver')
    end
  end

  context 'package url provided' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        file_cache_path: '/var/tmp/plexapp_chefspec'
      ) do |node|
        node.set['plexapp']['url'] = 'http://example.com/plex.deb'
      end.converge(described_recipe)
    end

    it 'downloads the package from a URI' do
      expect(chef_run).to create_remote_file(
        '/var/tmp/plexapp_chefspec/plex.deb'
      ).with(
        source: 'http://example.com/plex.deb'
      )
    end

    it 'installs the package file' do
      expect(chef_run).to install_package('plexmediaserver').with(
        source: '/var/tmp/plexapp_chefspec/plex.deb'
      )
    end
  end
end
