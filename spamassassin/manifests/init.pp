# Spamassassin
# ============
class spamassassin::daemon {
        package {"spamassassin": ensure => installed }

	service {"spamassassin":
		ensure  => stopped,
		require => Package["spamassassin"]
	}

	file {"/etc/default/spamassassin":
		ensure  => present,
		content => template("spamassassin/etc/default/spamassassin"),
		notify  => Service["spamassassin"]
	}

	include helpers
}

class spamassassin::helpers {
	package {["razor", "pyzor"]: ensure => installed}
}
