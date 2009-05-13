# Avira Webgate
# =============
class avwebgate::server {
	# TODO: No package available

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
}
