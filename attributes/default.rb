# Specify the version of Plex to install here. This will be used to
# construct the URL (and cached package file) with the helper library
# method, plexapp_package_url, and plexapp_package_file.
#
default['plexapp']['version'] = '1.9.0.4252-d07c1f408'

# Specify the package URL to download here. The helper method will use
# this instead of constructing it with the version, above, from the
# Plex download site.
#
default['plexapp']['package_url'] = nil

# Some plexserver knobs
#
default['plexapp']['max_plugin_procs'] = 6
default['plexapp']['max_stack_size'] = 3000
default['plexapp']['application_support_dir'] = "${HOME}/Library/Application Support"
default['plexapp']['tmpdir'] = "/tmp"
default['plexapp']['user'] = "plex"
