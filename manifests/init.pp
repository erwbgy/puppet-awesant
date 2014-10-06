# Class: awesant
#
# This module manages the awesant, lightweight logstash shipper whitten in Perl.
# https://github.com/bloonix/awesant
#
# Parameters:
#
#  [*manage_repo*]
#    Manages repo installation, default to true
#
# Actions:
#
# Requires:
#
# Sample Usage:
# 
# class { 'awesant': }
#
class awesant (
  $config_template = 'awesant/agent.conf.erb',
  $manage_repo	   = true,
) {
  
  anchor { 'awesant::begin': }
  anchor { 'awesant::end': }
  
  class { 'awesant::repo':}
  class { 'awesant::install': }
  class { 'awesant::config': config_template => $config_template, }
  class { 'awesant::service': }

  Anchor['awesant::begin']
  -> Class['awesant::repo']
  -> Class['awesant::install']
  -> Class['awesant::config']
  -> Class['awesant::service']
  -> Anchor['awesant::end']

}