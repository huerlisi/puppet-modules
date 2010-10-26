# Avira Webgate
# =============
#
# Checks if the archithecture is amd64.
# Installs the package ia32-libs.
# Starts the service avwebgate.
# Adds the content from avwebgate/etc/avwebgate.conf to /etc/avwebgate.conf
# and from avwebgate/etc/avwebgate-scanner.conf to /etc/avwebgate-scanner.conf.
# Checks the file /var/log/antivir for owner, group, mode and directory.         
#
class avwebgate::server {
	# TODO: No package available

	case $architecture {
	"amd64": { package {"ia32-libs": ensure => installed} }
	}

	service {"avwebgate":
		ensure => running
	}

	file {"/etc/avwebgate.conf":
		content => template("avwebgate/etc/avwebgate.conf"),
		notify  => Service["avwebgate"]
	}
	file {"/etc/avwebgate-scanner.conf":
		content => template("avwebgate/etc/avwebgate-scanner.conf"),
		notify  => Service["avwebgate"]
	}

	file {"/var/log/antivir":
		ensure => directory,
		owner  => "root",
		group  => "antivir",
		mode   => "2775"
	}
}

#
# Adds the content avwebgate/etc/squid/conf.d/avwebgate.conf to 
# /etc/squid/conf.d/avwebgate.conf.
# Starts service avwebgate and checks if /etc/squid/conf.d exists.
# Notifies the service squid.
#
# Requires:
# squid::server
#
class avwebgate::squid {
	include squid::server

	file {"/etc/squid/conf.d/avwebgate.conf":
		content => template("avwebgate/etc/squid/conf.d/avwebgate.conf"),
		require => Service["avwebgate"],
		require => File["/etc/squid/conf.d"],
		notify  => Service["squid"]
	}
	
}
