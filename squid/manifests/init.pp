# Squid
# =====
class squid::server {
	package {"squid": ensure => installed }

	service {"squid":
		ensure  => running,
		require => Package["squid"]
	}
}
