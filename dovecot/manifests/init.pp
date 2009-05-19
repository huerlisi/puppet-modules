# Dovecot
# =======
class dovecot::server {
        package {"dovecot-common": ensure => installed }

	service {"dovecot":
		ensure  => running,
		require => Package["dovecot-common"]
	}

	file {"/etc/dovecot/dovecot.conf":
		ensure  => present,
		content => template("dovecot/etc/dovecot/dovecot.conf"),
		notify  => Service["dovecot"],
		require => Package["dovecot-common"]
	}
}

class dovecot::server::imap {
	include dovecot::server

	package {"dovecot-imapd":
		ensure => installed,
		notify  => Service["dovecot"]
	}
}