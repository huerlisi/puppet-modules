# Munin
# =====
#
# Installs the package munin.
# Starts the service munin.
#
class munin::server {
        package {"munin": ensure => installed }
        service {"munin":
                ensure  => running,
                require => Package["munin"]
        }
}

#
# Installs the package munin-node.
# Starts the service munin-node.
# Adds the file /etc/munin/munin-node.conf with content munin/etc/munin/munin-node.conf.
#
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
