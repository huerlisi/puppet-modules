# Bacula
# ======
# 
# Installs the package nagios-nrpe-server. This starts all needed daemons and services for nagios3-server.
# Starts the service nagios-nrpe-server.
#
class bacula::client {
        package {"bacula-client": ensure => installed }
        service {"bacula-fd":
                ensure  => running,
		pattern => 'bacula-fd',
                require => Package["bacula-client"]
	}
        file { "/etc/bacula/bacula-fd.conf":
                content => template('bacula/etc/bacula/bacula-fd.conf'),
                notify  => Service["bacula-fd"],
		require => Package["bacula-client"]
        }

}
