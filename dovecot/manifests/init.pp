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
		require => Package["dovecot-core"]
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
  package {"dovecot-core": ensure => installed }

	service {"dovecot":
		ensure  => running,
		require => Package["dovecot-core"]
	}

	file {"/etc/dovecot/dovecot.conf":
		ensure  => present,
		content => template("dovecot/etc/dovecot/dovecot.conf"),
		notify  => Service["dovecot"],
		require => Package["dovecot-core"]
	}

	user {"vmail":
		shell => '/bin/false',
		ensure => present,
		home   => "/srv/${mail_domain}/maildir/"
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
