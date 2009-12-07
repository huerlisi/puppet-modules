# Rsyslog
# =======
class rsyslog::daemon {
        package {"rsyslog": ensure => installed }
        service {"rsyslog":
                ensure  => running,
                require => Package["rsyslog"]
        }
}

class rsyslog::client inherits rsyslog::daemon {
        file { "/etc/rsyslog.d/to-remote.conf":
                content => template('rsyslog/etc/rsyslog.d/to-remote.conf'),
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}

class rsyslog::server inherits rsyslog::daemon {
        file { "/etc/rsyslog.d/allow-remote.conf":
                content => template('rsyslog/etc/rsyslog.d/allow-remote.conf'),
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}
