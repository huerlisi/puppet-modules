# Squid
# =====
#
# Installs the package squid.
# Starts the service squid.
# Checks if /etc/squid/conf.d is a directory.
# Adds the file /etc/squid/conf.d/dummy.conf.
# Adds the file /etc/squid/conf.d/localnet.acl with content squid/etc/squid/conf.d/localnet.acl.
# Adds the file /etc/squid/conf.d/cache_dir.conf with content squid/etc/squid/conf.d/cache_dir.conf.
# Adds the file /etc/squid/squid.conf with content squid/etc/squid/squid.conf.
#
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
