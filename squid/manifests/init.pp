# Squid
# =====
class squid::server {
	package {"squid": ensure => installed }

	service {"squid":
		ensure  => running,
		require => Package["squid"]
	}

	file {"/etc/squid/squid.conf":
		content => template("squid/etc/squid/squid.conf"),
		notify  => Service["squid"],
		require => Package["squid"]
	}
}
