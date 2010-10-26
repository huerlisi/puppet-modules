# NIS
# ===
#
# Installs the package nis and libpam-unix2.
# Starts the service nis with status test -f /var/run/ypbind.pid.
# Adds the file /etc/yp.conf with content nis/etc/yp.conf.
# Adds the file /etc/defaultdomain with content $network.
# Adds the file /etc/pam.d/common-auth with content nis/etc/pam.d/common-auth.
# Executes /bin/echo '+::::::' >>/etc/passwd.
# Executes /bin/echo '+:::' >>/etc/group.
# Executes /bin/echo '+::::::::' >>/etc/shadow.
#
# Parameters
# $network
# Name of the network.
#
class nis::client {
        package {"nis": ensure => installed }
        service {"nis":
                ensure  => running,
                require => Package["nis"],
                status  => "test -f /var/run/ypbind.pid"
        }

        file { "/etc/yp.conf":
                content => template('nis/etc/yp.conf'),
                require => Package["nis"],
                notify  => Service["nis"]
        }

        file { "/etc/defaultdomain":
                content => "$network",
                require => Package["nis"],
                notify  => Service["nis"]
        }

        exec { "nis passwd":
                command => "/bin/echo '+::::::' >>/etc/passwd",
                unless  => "/bin/grep '+::::::' /etc/passwd",
                require => Package["nis"]
        }
        exec { "nis group":
                command => "/bin/echo '+:::' >>/etc/group",
                unless  => "/bin/grep '+:::' /etc/group",
                require => Package["nis"]
        }

        # Login
        exec { "nis shadow":
                command => "/bin/echo '+::::::::' >>/etc/shadow",
                unless  => "/bin/grep '+::::::::' /etc/shadow",
                require => Package["nis"]
        }

        package {"libpam-unix2": ensure => installed }

        file { "/etc/pam.d/common-auth":
                content => template('nis/etc/pam.d/common-auth'),
                require => Package["nis"]
        }
}
