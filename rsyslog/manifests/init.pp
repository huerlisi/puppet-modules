# Rsyslog
# =======
class rsyslog::client {
        package {"rsyslog": ensure => installed }
        service {"rsyslog":
                ensure  => running,
                require => Package["rsyslog"]
        }

        file { "/etc/rsyslog.d/to-remote.conf":
                content => template('rsyslog/etc/rsyslog.d/to-remote.conf'),
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}
