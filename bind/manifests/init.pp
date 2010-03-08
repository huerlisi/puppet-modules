# Bind
# ====
class bind::server {
        package {"bind9": ensure => installed }

	service {"bind9":
		ensure  => running,
		pattern => 'named',
		require => Package["bind9"]
	}

	file {"/etc/bind/zones.d":
		ensure  => directory,
		require => Package["bind9"]
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
