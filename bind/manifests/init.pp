# Bind
# ====
#
# Installs package bind9 and checks if the service bind9 is running.
# Adds pattern named.
# Adds directory /etc/bind/zones.d
#
class bind::server {
  package {"bind9": ensure => installed }

	service {"bind9":
		ensure  => running,
		pattern => 'named',
		require => Package["bind9"]
	}
}

# Forwarding Proxy
# ================
#
# Adds content from bind/etc/bind/named.conf.options to /etc/bind/named.conf.options.
# Notifies the service bind9
#
# Requires:
# server
#
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
