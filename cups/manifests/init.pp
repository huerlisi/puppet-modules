# CUPS
# ====
#
# Installs the packages cups, hpijs, hpijs-ppds, foomatic-db, 
# foomatic-db-engine, foomatic-db-hpijs, openprinting-ppds.
# Starts the service cups.
# Adds the file /etc/cups/cupsd.conf with the content from cups/etc/cups/cupsd.conf.
# Notifies the service cups.
#
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
