# Avira Webgate
# =============
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

class avwebgate::squid {
	include squid::server

	file {"/etc/squid/conf.d/avwebgate.conf":
		content => template("avwebgate/etc/squid/conf.d/avwebgate.conf"),
		require => Service["avwebgate"],
		require => File["/etc/squid/conf.d"],
		notify  => Service["squid"]
	}
	
}
