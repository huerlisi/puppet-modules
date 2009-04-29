# AutoFS
# ======
class autofs::client {
        package {"autofs": ensure => installed }
        service {"autofs":
                ensure  => running,
                require => Package["autofs"]
        }

        include nfs::client
        file { "/etc/auto.master":
                content => template('autofs/etc/auto.master'),
                notify  => Service["autofs"],
                require => Package["autofs"]
        }
}
