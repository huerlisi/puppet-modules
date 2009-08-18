# Squid
# =====
class squid::server {
	package {"squid": ensure => installed }

	service {"squid":
		ensure  => running,
		require => Package["squid"]
	}

	file {"/etc/squid/conf.d":
		ensure  => directory,
		require => Package["squid"]
	}

	# Squid won't start without at least one .conf file in conf.d ...
	file {"/etc/squid/conf.d/dummy.conf":
		ensure  => present,
		require => File["/etc/squid/conf.d"]
	}

	file {"/etc/squid/conf.d/localnet.acl":
		ensure  => present,
		content => template("squid/etc/squid/conf.d/localnet.acl"),
		require => File["/etc/squid/conf.d"],
		require => Package["squid"],
		notify  => Service["squid"],
	}

	file {"/etc/squid/conf.d/cache_dir.conf":
		ensure  => present,
		content => template("squid/etc/squid/conf.d/cache_dir.conf"),
		require => File["/etc/squid/conf.d"],
		require => Package["squid"],
		notify  => Service["squid"],
	}

	file {"/etc/squid/squid.conf":
		content => template("squid/etc/squid/squid.conf"),
		notify  => Service["squid"],
		require => Package["squid"],
		require => File["/etc/squid/conf.d"]
	}
}
