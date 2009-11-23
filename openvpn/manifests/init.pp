# OpenVPN
# =======
class openvpn::server {
	package {"openvpn": ensure => installed }

	service {"openvpn":
		ensure  => running,
		require => Package["openvpn"]
	}
}

class openvpn::bridge inherits openvpn::server {
	include network::bridge

	file {"/etc/openvpn/$title.conf":
		ensure  => present,
		content => template("openvpn/etc/openvpn/bridge.conf"),
		require => Package["openvpn"]
	}
}

class openvpn::client {
	package {"openvpn": ensure => installed }

	service {"openvpn":
		ensure  => running,
		require => Package["openvpn"]
	}
}
