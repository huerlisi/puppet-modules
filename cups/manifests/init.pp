# CUPS
# ====
class cups::server {
	package {"cups": ensure => installed}

	service {"cups":
		ensure  => running,
		require => Package["cups"]
	}

	file {"/etc/cups/cupsd.conf":
		ensure => file,
		content => template("cups/etc/cups/cupsd.conf"),
		require => Package["cups"],
		notify  => Service["cups"]
	}
}
