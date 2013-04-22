class awesant (
  $config_template = 'awesant/agent.conf.erb',
) {
  include awesant::install
  class { 'awesant::config':
    config_template => $config_template,
  }
  include awesant::service
}
