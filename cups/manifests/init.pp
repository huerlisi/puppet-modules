# CUPS
# ====
class cups::server {
	package {["cups", "hpijs", "hpijs-ppds", "foomatic-db", "foomatic-db-engine", "foomatic-db-hpijs", "openprinting-ppds"]: ensure => installed}

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
