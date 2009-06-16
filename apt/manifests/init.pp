# APT
# ===
class apt::client {
	file {"/etc/apt/apt.conf.d/proxy":
		content => template("apt/etc/apt/apt.conf.d/proxy")
	}
	file {"/etc/apt/apt.conf.d/no-install-recommends":
		content => template("apt/etc/apt/apt.conf.d/no-install-recommends")
	}
}

class apt::unattended-upgrades {
	package {"unattended-upgrades": ensure => installed}
}
