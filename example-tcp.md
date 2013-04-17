# puppet-awesant

## Example config: TCP

Read from a log file and send entries over TCP.

### /etc/awesant/agent.conf

    input {
        file {
            type syslog
            path /var/log/messages
        }
    }
    
    output {
        socket {
            type syslog
            host 10.7.16.38
            port 5544
        }
    }
    
    logger {
        file {
            filename /var/log/awesant/agent.log
            maxlevel info
        }
    }

### /etc/logstash/agent/config/logstash.conf

    input {
      tcp {
        type => "syslog"
        format => "json_event"
        port => 5544
      }
    }
    output {
      file {
        type => 'syslog'
        message_format => "%{@message}"
        path => "/apps/logstash/logs/syslog.log"
      }
    }

### /var/log/awesant/agent.log

    {"@source":"tcp://10.7.192.53:50065/","@tags":[],"@fields":{},"@timestamp":"2013-04-17T15:54:31.218Z","@source_host":"10.7.192.53","@source_path":"/","@message":"{\"@timestamp\":\"2013-04-17T16:54:31+01:00\",\"@tags\":[],\"@fields\":{},\"@source\":\"file://wokls00002/var/log/messages\",\"@source_path\":\"/var/log/messages\",\"@source_host\":\"wokls00002\",\"@message\":\"Apr 17 16:54:30 wokls00002 kburdis: ook?\",\"@type\":\"syslog\"}\n","@type":"syslog"}
