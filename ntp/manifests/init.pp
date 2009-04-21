# NTP
# ===
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
