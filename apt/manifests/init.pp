# APT
# ===
class apt::client {
	file {"/etc/apt/apt.conf.d/proxy":
		content => template("apt/etc/apt/apt.conf.d/proxy")
	}
}

class apt::unattended-upgrades {
	package {"unattended-upgrades": ensure => installed}
}
