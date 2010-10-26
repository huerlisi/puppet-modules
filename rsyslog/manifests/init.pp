# Rsyslog
# =======
#
# Installs the paqckage rsyslog.
# Starts the service rsyslog.
#
class rsyslog::daemon {
        package {"rsyslog": ensure => installed }
        service {"rsyslog":
                ensure  => running,
                require => Package["rsyslog"]
        }
}

#
# Adds the file /etc/rsyslog.d/to-remote.conf with content rsyslog/etc/rsyslog.d/to-remote.conf.
# Checks if the package rsyslog is installed and the service is running.
#
class rsyslog::client inherits rsyslog::daemon {
        file { "/etc/rsyslog.d/to-remote.conf":
                content => template('rsyslog/etc/rsyslog.d/to-remote.conf'),
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}

#
# Adds the file /etc/rsyslog.d/allow-remote.conf with content rsyslog/etc/rsyslog.d/allow-remote.conf.
# Checks if the package rsyslog is installed and the service is running.
#
class rsyslog::server inherits rsyslog::daemon {
        file { "/etc/rsyslog.d/allow-remote.conf":
                content => template('rsyslog/etc/rsyslog.d/allow-remote.conf'),
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}
