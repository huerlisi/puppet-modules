# Nagios
# ======
# 
# Installs the package nagios-nrpe-server. This starts all needed daemons and services for nagios3-server.
# Starts the service nagios-nrpe-server.
#
class nagios::cyt-client {
        package {"nagios-nrpe-server": ensure => installed }
        service {"nagios-nrpe-server":
                ensure  => running,
		pattern => 'nrpe',
                require => Package["nagios-nrpe-server"]
	}
        file { "/etc/nagios/nrpe.cfg":
                content => template('nagios/etc/nagios/nrpe.cfg'),
                notify  => Service["nagios-nrpe-server"],
		require => Package["nagios-nrpe-server", "nagios-plugins-standard"]
        }

        package {"nagios-plugins-standard": ensure => installed }
	package {"snmpd": ensure => installed }
	service {"snmpd":
		ensure 	=> running,
		pattern	=> 'snmpd',
		require => Package["snmpd"]
	}
        file { "/etc/snmp/snmpd.conf":
                content => template('nagios/etc/snmp/snmpd.conf'),
                notify  => Service["snmpd"],
		require => Package["snmpd", "nagios-snmp-plugins"]
        }

	package {"nagios-snmp-plugins": ensure => installed }
}
