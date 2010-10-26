# Dovecot
# =======
#
# Installs the package dovecot-common.
# Starts the service dovecot.
# Adds the file /etc/dovecot/dovecot-ldap.conf with content from 
# dovecot/etc/dovecot/dovecot-ldap.conf
#
class dovecot::ldap {
	file {"/etc/dovecot/dovecot-ldap.conf":
		ensure  => present,
		content => template("dovecot/etc/dovecot/dovecot-ldap.conf"),
		notify  => Service["dovecot"],
		require => Package["dovecot-common"]
	}
}

#
# Installs the package dovecot-common.
# Starts the service dovecot.
# Adds the file /etc/dovecot/dovecot.conf with content dovecot/etc/dovecot/dovecot.conf.
#
# Parameters:
# $dovecot_auth 
# Authentification for dovecut.
#
# Requires:
# ldap
#
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

	if $dovecot_auth {
		include ldap
	}
}

#
# Installs the package dovecot-imapd and starts the service dovecot.
#
# Requires:
# dovecot::server
#
class dovecot::server::imap {
	include dovecot::server

	package {"dovecot-imapd":
		ensure => installed,
		notify  => Service["dovecot"]
	}
}
