= awesant

Install the awesant log shipper for Logstash with a configuration file.

To use just:

    include awesant

and then specify the location of the config template in hiera - for example:

    awesant::config_template: '/etc/puppet/templates/myapp/awesant-agent.conf.erb'

Alternatively you call it as a parameterised class:

    class { 'awesant':
      config_template => '/etc/puppet/templates/myapp/awesant-agent.conf.erb'
    }

## Installation

Installation assumes that an 'awesant' package is available from the package
repository.  See http://download.bloonix.de/ for pre-built packages for
RedHat-like and Debian-like hosts.

## Configuration

See https://github.com/bloonix/awesant for documentation on awesant configuration.

By default the following template is used to give you a starting point:

    input {
        file {
            type awesant
            tags syslog-messages
            path /var/log/messages
        }
        file {
            type awesant
            tags syslog-secure
            path /var/log/secure
        }
    }
    
    output {
        socket {
            type awesant
            host logstash.domain.com
            port 5544
        }
    }
    
    logger {
        file {
            filename /var/log/awesant/agent.log
            maxlevel info
        }
    }

The corresponding Logstash configuration could be:

    input {
      tcp {
        format => "json_event"
        host => logstash.domain.com
        port => 5544
        type => "awesant"
      }
    }
    filter {
      grok {
        match => [ "@timestamp", "^%{DATE_EU:date}" ]
        type => "awesant"
      }
    }
    output {
      file {
        tags => 'syslog-messages'
        message_format => "%{@message}"
        path => "/apps/logstash/logs/syslog/messages-%{date}.log"
      }
      file {
        tags => 'syslog-secure'
        message_format => "%{@message}"
        path => "/apps/logstash/logs/syslog/secure-%{date}.log"
      }
    }

You can use any facter facts in your template - for example 'fqdn' or a custom fact like 'logstash_host'.

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-tomcat
