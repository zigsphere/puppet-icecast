# Icecast configuration files

class icecast::config {

  $install_directory = $::icecast::install_directory
  $service_group     = $::icecast::service_group
  $service_user      = $::icecast::service_user

  file { "${install_directory}/icecast.xml":
    ensure  => present,
    owner   => $service_user,
    group   => $service_group,
    mode    => 0660,
    content => template("${module_name}/icecast.xml.erb"),
    require => Class['icecast::install'],
    notify  => Service['icecast'],
  }

}
