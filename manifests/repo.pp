# Private class that manages awesant repo creation. 
# Controls by $awesant::manage_repo, true by default.
class awesant::repo {

  Exec {
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd  => '/',
  }

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $::osfamily {
    'Debian': {
      if defined(apt::source) {

        $ensure = $awesant::manage_repo ? {
          false    => 'absent',
          default  => 'present'
        }

        apt::source { 'awesant':
          ensure      => $ensure,
          location    => 'http://download.bloonix.de/repos/debian',
          repos       => 'main',
          key         => '92388145',
          key_source  => 'http://download.bloonix.de/bloonix.gpg',
          include_src => false,
          before      => Package['awesant'],
        }
      } else {
        fail('This class requires puppet-apt module')
      }
    }
  default: {
    fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
  }
}
}