# AutoFS
# ======
#
# Sets the variable autofs_net to /mnt/net.
# Installs the package autofs.
# Checks if the service autofs is running.
# Add content from template autofs/etc/auto.master into /etc/auto.master.
#
# Requires:
# nfs::client
#
class autofs::client {
	$autofs_net = '/mnt/net'

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
