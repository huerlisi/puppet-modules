# OpenVPN
# =======
#
# Installs the package openvpn.
# Starts the service openvpn.
#
class openvpn::server {
	package {"openvpn": ensure => installed }

  exec { "Generating DH parameters":
    path    => ["/usr/sbin", "/usr/bin", "/sbin", "/bin"],
    command => "openssl dhparam -out /etc/openvpn/dh2048.pem 2048",
    creates => "/etc/openvpn/dh2048.pem",
    notify  => Service["openvpn"]
  }

	service {"openvpn":
		ensure  => running,
		require => Package["openvpn"]
	}
}

#
# Adds the file /etc/openvpn/$title.conf with content openvpn/etc/openvpn/bridge.conf.
#
# Parameters
# $title.conf
# Name of the openvpnfile.
#
# Requires
# openvpn::server
# network::bridge
#
define openvpn::bridge() {
	include openvpn::server
	include network::bridge

	file {"/etc/openvpn/$title.conf":
		ensure  => present,
		content => template("openvpn/etc/openvpn/bridge.conf"),
		require => Package["openvpn"],
		notify  => Service["openvpn"]
	}
}

#
# Installs the package openvpn.
# Starts the service openvpn.
#
class openvpn::client {
	package {"openvpn": ensure => installed }

	service {"openvpn":
		ensure  => running,
		require => Package["openvpn"]
	}
}
