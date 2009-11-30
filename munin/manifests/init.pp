# Munin
# =====
class munin::server {
        package {"munin": ensure => installed }
        service {"munin":
                ensure  => running,
                require => Package["munin"]
        }
}

class munin::client {
        package {"munin-node": ensure => installed }
        service {"munin-node":
                ensure  => running,
                require => Package["munin-node"]
        }

        file { "/etc/munin/munin-node.conf":
                content => template('munin/etc/munin/munin-node.conf'),
                notify  => Service["munin-node"],
		require => Package["munin-node"]
        }
}
