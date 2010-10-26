# Spamassassin
# ============
#
# Installs the package spamassassin.
# Starts the service spamassassin.
# Adds the file /etc/default/spamassassin with content spamassassin/etc/default/spamassassin.
# 
# Requires
# spamassassin::helpers
#
class spamassassin::daemon {
        package {"spamassassin": ensure => installed }

	service {"spamassassin":
		ensure  => running,
		require => Package["spamassassin"]
	}

	file {"/etc/default/spamassassin":
		ensure  => present,
		content => template("spamassassin/etc/default/spamassassin"),
		notify  => Service["spamassassin"]
	}

	include helpers
}

#
# Installs the packages razor and pyzor.
#
class spamassassin::helpers {
	package {["razor", "pyzor"]: ensure => installed}
}
