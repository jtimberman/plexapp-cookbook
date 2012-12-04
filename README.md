# plexapp cookbook

This cookbook installs and configures Plex Media Server.

# Requirements

## Platform

Currently supported platforms:

* Ubuntu 12.04

# Installation

You should install the cookbook from the Opscode Chef Community site,
not directly from the git repository. The git repository may contain
changes that are untested.

## knife

Download and extract the cookbook in your cookbooks directory.

    knife cookbook site download plexapp
    tar -zxvf plexapp-*.tar.gz -C cookbooks

Or, if you use the "vendor branch" workflow:

    knife cookbook site install plexapp

## Berkshelf

In your top-level Chef repository Berksfile:

    cookbook "plexapp"

## Librarian Chef

In your Chef repository Cheffile:

    cookbook "plexapp"

# Usage

Modify the attributes as required in a role or wrapper cookbook, and
add the default recipe to the run list. For example, I have a
"plex-server" role that looks like this:

    name "plex-server"
    run_list("recipe[plexapp]")

# Recipes

## server_ubuntu

Adds Plex apt repository, installs the package and manages the service
using upstart.

## default

Includes the appropriate recipe based on `node['platform']`.

# Roadmap

* Support additional platforms. Plex Media Server itself supports
  Fedora, CentOS, Mac OS X and Windows.
* Support client installation.

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Author

- Author: Joshua Timberman (<cookbooks@housepub.org>)
- Copyright:: (c) 2012, Joshua Timberman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
