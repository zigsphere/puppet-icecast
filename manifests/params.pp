# Author::    Joseph Ziegler  (mailto:joseph@josephziegler.com)
# Copyright:: Copyright (c) 2018 ZigSphere
# License::   MIT

# == Class icecast::params

class icecast::params {

  # this is all only tested on Debian and RedHat
  # params gets included everywhere so we can do the validation here
  unless $facts['os']['family'] =~ /(RedHat|Debian)/ {
    warning("${facts['os']['family']} is not supported")
  }

  $admin_password    = 'password',
  $admin_user        = 'admin',
  $email             = 'icemaster@localhost',
  $hostname          = 'localhost',
  $install_directory = '/opt/icecast-server',
  $location          = 'Earth',
  $log_level         = '3',
  $port              = '8000',
  $relay_password    = 'hackme',
  $service_group     = 'icecast',
  $service_user      = 'icecast',
  $source_password   = 'password',
  $version           = '2.4.3'
  $sub_download_url  = 'http://downloads.xiph.org/releases/icecast/'
  $download_source   = "${sub_download_url}/icecast-${version}.tar.gz"

}
