# APT
# ===
class apt::client {
	if $proxy_server_url {
		file {"/etc/apt/apt.conf.d/proxy":
			content => template("apt/etc/apt/apt.conf.d/proxy")
		}
	} else {
		file {"/etc/apt/apt.conf.d/proxy": ensure => absent }
	}

	# proxy-guess ist configured by xen-tools
	file {"/etc/apt/apt.conf.d/proxy-guess": ensure => absent }

	file {"/etc/apt/apt.conf.d/no-install-recommends":
		content => template("apt/etc/apt/apt.conf.d/no-install-recommends")
	}
}

class apt::unattended-upgrades {
	package {"unattended-upgrades": ensure => installed}
}
