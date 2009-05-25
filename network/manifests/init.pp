# Networking
# ==========

class network::interfaces {
	if $network_interface_template {
		file {"/etc/network/interfaces":
			ensure  => present,
			content => template($network_interface_template)
		}
	} else {
		file {"/etc/network/interfaces":
			ensure  => present,
			content => template("network/etc/network/interfaces")
		}
	}
}
