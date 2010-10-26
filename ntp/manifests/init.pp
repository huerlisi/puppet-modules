# NTP
# ===
#
# Installs the package ntp.
# Starts the service ntp.
# Adds the file /etc/ntp.conf with content ntp/etc/ntp.conf.
#
class ntp::client {
        package {"ntp": ensure => installed }
        service {"ntp":
                ensure  => running,
                require => Package["ntp"]
        }

        file { "/etc/ntp.conf":
                content => template('ntp/etc/ntp.conf'),
                notify  => Service["ntp"],
                require => Package["ntp"]
        }
}

#
# Requires
# ntp::client
#
class ntp::server {
	include ntp::client
}
