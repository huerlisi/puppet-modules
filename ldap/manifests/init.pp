# LDAP
# ====
class ldap::client {
	file {"/etc/ldap": ensure => directory}
	file {"/etc/ldap/ldap.conf":
		ensure  => file,
		content => template("ldap/etc/ldap/ldap.conf"),
		require => File["/etc/ldap"]
	}
}

class ldap::utils {
	include ldap::client
	package {"ldap-utils": ensure => installed}
}

class ldap::server {
        package {"slapd": ensure => installed}

	service {"slapd":
		ensure  => running,
		require => Package["slapd"]
	}

	file {"/etc/ldap/slapd.conf":
		ensure  => file,
		owner   => 'root',
		group   => 'openldap',
		mode    => '640',
		content => template("ldap/etc/ldap/slapd.conf"),
		require => Package["slapd"],
		notify  => Service["slapd"]
	}

	include ldap::utils
}

class ldap::pam {
	include ldap::client
	include ldap::nss

	package {"libpam-ldap": ensure => installed}

	file {"/etc/pam_ldap.conf":
		content => template("ldap/etc/pam_ldap.conf")
	}

	file { "/etc/pam.d/common-account":
	        content => template("ldap/etc/pam.d/common-account")
	}
	file { "/etc/pam.d/common-auth":
        	content => template("ldap/etc/pam.d/common-auth")
	}
	file { "/etc/pam.d/common-password":
	        content => template("ldap/etc/pam.d/common-password")
	}
	file { "/etc/pam.d/common-session":
	        content => template("ldap/etc/pam.d/common-session")
	}
}

class ldap::nss {
	package {"libnss-ldapd": ensure => installed}

	file {"/etc/nss-ldapd.conf":
		content => template("ldap/etc/nss-ldapd.conf")
	}

	file {"/etc/nsswitch.conf":
		content => template("ldap/etc/nsswitch.conf")
	}
}
