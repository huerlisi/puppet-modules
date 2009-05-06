# Bind
# ====
class bind::server {
        package {"bind9": ensure => installed }

	# TODO: state check doesn't work
	service {"bind9":
		ensure  => running,
		require => Package["bind9"]
	}

	file {"/etc/bind/zones.d":
		ensure => directory
	}
}

# Forwarding Proxy
# ================
class bind::proxy {
	include server

	file {"/etc/bind/named.conf.options":
		ensure  => present,
		content => template("bind/etc/bind/named.conf.options"),
		notify  => Service["bind9"]
	}
}

# Master Zone
# ===========
define bind::zone::master() {
}
