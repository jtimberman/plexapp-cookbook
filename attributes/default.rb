# Specify the version of Plex to install here. This will be used to
# construct the URL (and cached package file) with the helper library
# method, plexapp_package_url, and plexapp_package_file.
#
default['plexapp']['version'] = '0.9.12.3.1173-937aac3'

# Specify the package URL to download here. The helper method will use
# this instead of constructing it with the version, above, from the
# Plex download site.
#
default['plexapp']['package_url'] = nil
