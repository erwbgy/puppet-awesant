class awesant::service {
  service { 'awesant-agent':
    ensure  => 'running',
    enable  => true,
    require => Class['awesant::config'],
  }
}
