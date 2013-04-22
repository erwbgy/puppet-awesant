class awesant::config (
  $config_template,
) {
  file { '/etc/awesant/agent.conf':
    ensure  => 'present',
    content => template($config_template),
    notify  => Class['awesant::service'],
    require => Class['awesant::install'],
  }
}
