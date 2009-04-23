# Networking
# ==========

class network::interfaces {
	file {"/etc/network/interfaces":
		ensure  => present,
		content => template("network/etc/network/interfaces")
	}
}
