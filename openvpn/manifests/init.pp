# OpenVPN
# =======
class openvpn::server {
	package {"openvpn": ensure => installed }

	service {"openvpn":
		ensure  => running,
		require => Package["openvpn"]
	}
}

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

class openvpn::client {
	package {"openvpn": ensure => installed }

	service {"openvpn":
		ensure  => running,
		require => Package["openvpn"]
	}
}

class openvpn::ca {
	package {"easy-rsa":
		ensure  => installed,
		require => Apt::Ppa["huerlisi-ppa"]
	}
}
