# plexapp cookbook

This cookbook installs and configures Plex Media Server.

# Requirements

## Platform

Currently supported platforms:

* Ubuntu 14.04
* Fedora 21

It should also just work on RHEL platforms, but they're not included in the test kitchen matrix.

In the future this may support OS X, and FreeBSD. There are conditional branches in the helpers, but the server recipe will fail, since the package and service resources won't converge on those platforms at this time.

# Attributes

See `./attributes/default.rb`.

# Recipes

## server

Adds Plex apt repository, installs the package and manages the service
using upstart.

## default

Includes the server recipe.

# Roadmap

* Support server installs on Windows, OS X, and FreeBSD.
* Support client installation.

# Contributing

1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Ensure that you add ChefSpec test coverage, and any relevant modifications to the `.kitchen.yml`.
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request

# Author

- Author: Joshua Timberman (<cookbooks@housepub.org>)
- Copyright:: (c) 2012-2015, Joshua Timberman

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
