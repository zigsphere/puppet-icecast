# == Class: icecast
#
#========================================================================
# This module is not yet completed!!
# TO DO:
#  * Add variables for all attributes in the icecast.xml file
#  * Add firewall rules
#  * Add ability to add mounts
# =======================================================================
# "Icecast is a streaming media (audio/video) server which currently supports
#  Ogg (Vorbis and Theora), Opus, WebM and MP3 streams. It can be used to create
#  an Internet radio station or a privately running jukebox and many things in
#  between. It is very versatile in that new formats can be added relatively
#  easily and supports open standards for communication and interaction."
#
# === Parameters
#
#  [*admin_password*]
#    Password for the icecast admin user for web console
#
#  [*admin_user*]
#    Icecast username for the icecast web console
#
#  [*sub_download_url*]
#    In the event the download mirror needs to be changed, this can be set here
#
#  [*download_source*]
#    This is the fully qualified download URL for the icecast tarball
#
#  [*email*]
#    Contact email for the icecast web portal
#
#  [*hostname*]
#    Hostname for the icecast server (e.g icecast.domain.com)
#
#  [*install_directory*]
#    Directory that the icecast package will download and extract to
#
#  [*location*]
#    Location to display on the icecast web portal
#
#  [*log_level*]
#    Log level for access and error logs
#
#  [*port*]
#    Port in which the icecast server will listen on
#
#  [*service_group*]
#    the group in which the icecast service will run
#
#  [*service_user*]
#    The user in which will run the icecast service
#
#  [*source_password*]
#    The unencrypted password used by sources to connect to icecast
#
#  [*version*]
#    The version of icecast to install from source
#
# === Examples
#
#  class { '::icecast':
#    admin_password    => 'foo',
#    admin_user        => 'bar',
#    hostname          => 'icecast.domain.com',
#    install_directory => '/opt/directory',
#    service_user      => 'icecast',
#    service_group     => 'icecast',
#    source_password   => 'a_strong_password',
#    version           => '2.4.3',
#  }
# OR
#  class { '::icecast':
#    admin_password    => 'foo',
#    admin_user        => 'bar',
#    hostname          => 'icecast.domain.com',
#    source_password   => 'a_strong_password',
#  }
#
# === Authors
#
# Joseph Ziegler <joseph@josephziegler.com>
#
# === Copyright
#
# Copyright 2018 (c) ZigSphere
# License: Apache 2.0
#

class icecast(
  String $admin_password                  = $icecast::params::admin_password,
  String $admin_user                      = $icecast::params::admin_user,
  Stdlib::Httpurl $download_source        = $icecast::params::download_source,
  String $email                           = $icecast::params::email,
  String $hostname                        = $icecast::params::hostname,
  Stdlib::Absolutepath $install_directory = $icecast::params::install_directory,
  String $location                        = $icecast::params::location,
  Integer $log_level                      = $icecast::params::log_level,
  Integer $port                           = $icecast::params::port,
  String $relay_password                  = $icecast::params::relay_password,
  String $service_group                   = $icecast::params::service_group,
  String $service_user                    = $icecast::params::service_user,
  String $source_password                 = $icecast::params::source_password,
  Stdlib::Httpurl $sub_download_url       = $icecast::params::sub_download_url,
  String $version                         = $icecast::params::version,
  ) inherits icecast::params {

    # Anchor pattern to contain dependencies
    anchor { 'icecast::begin': }
    -> class { 'icecast::install': }
    -> class { 'icecast::config': }
    -> class { 'icecast::service': }
    -> anchor { 'icecast::end': }

}
