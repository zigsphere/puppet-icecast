# Author::    Joseph Ziegler  (mailto:joseph@josephziegler.com)
# Copyright:: Copyright (c) 2018 ZigSphere
# License::   Apache 2.0

class icecast::install {

  $download_source   = $::icecast::download_source
  $install_directory = $::icecast::install_directory
  $port              = $::icecast::port
  $service_group     = $::icecast::service_group
  $service_user      = $::icecast::service_user
  $version           = $::icecast::version

  package { [
    'g++',
    'make',
    'libvorbis-dev',
    'libxslt-dev',
    'libxslt1.1'
    ]
    ensure => present,
  }

  -> group { $service_group:
      ensure => present
    }

  -> user { $service_user
      ensure => present,
      groups => [$service_group]
    }

  file { $install_directory:
    ensure  => directory,
    owner   => $service_user,
    group   => $service_group,
    mode    => 0755,
    require => [
      Group[$service_group],
      User[$service_user],
    ],
  }

  file { '/var/log/icecast':
    ensure  => directory,
    owner   => $service_user,
    group   => $service_group,
    mode    => 0644,
    require => [
      Group[$service_group],
      User[$service_user],
    ],
  }

  archive { "icecast-${version}.tar.gz":
    path         => "${install_directory}/icecast-${version}.tar.gz"
    ensure       => present,
    extract      => true,
    extract_path => $install_directory,
    source       => $download_source,
    creates      => "${install_directory}/icecast-${version}",
    cleanup      => true,
    user         => $service_user,
    group        => $service_group,
    require      => [
      File[$install_directory],
      Group[$service_group],
      User[$service_user],
    ],
    notify       => Exec['make'],
  }

  exec { 'make':
    command     => './configure && /usr/bin/make',
    cwd         => "${install_directory}/icecast-${version}",
    user        => 'root',
    refreshonly => true,
    timeout     => '900',
    require     => Archive["icecast-${version}.tar.gz"],
    notify      => Exec['make_install'],
  }

  exec { 'make_install':
    command     => '/usr/bin/make install',
    cwd         => "${install_directory}/icecast-${version}",
    user        => 'root',
    refreshonly => true,
    timeout     => '900',
    require     => Archive["icecast-${version}.tar.gz"],
  }

  firewall { '100 allow icecast access':
    ensure => present,
    dport  => $port,
    proto  => 'tcp',
    action => 'accept',
  }

}
