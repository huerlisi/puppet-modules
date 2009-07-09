# OpenVPN
# =======
class openvpn::server {
	package {"openvpn": ensure => installed }

	service {"openvpn":
		ensure  => running,
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
