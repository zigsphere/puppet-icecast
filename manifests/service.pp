# Icecast service configuration

class icecast::service {

  systemd::unit_file { 'icecast.service':
    content => template("${module_name}/icecast.service.erb"),
  } ~> service {'icecast':
    ensure  => running,
    enable  => true.
    require => [
      Class['icecast::config'],
      Class['icecast::install']
    ]
  }
}
