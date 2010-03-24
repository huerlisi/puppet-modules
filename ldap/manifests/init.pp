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

	file {"/etc/ldap/slapd.conf.d":
		ensure  => directory,
		require => Package["slapd"]
	}

	file {"/etc/ldap/slapd.conf.d/options":
		ensure  => file,
		content => template("ldap/etc/ldap/slapd.conf.d/options"),
		require => [ Package["slapd"], File["/etc/ldap/slapd.conf.d"] ],
		notify  => Service["slapd"]
	}

	case $lsbdistcodename {
		'intrepid', 'karmic': {
                        file {"/etc/default/slapd":
                                ensure  => file,
                                content => template("ldap/etc/default/slapd"),
                                require => Package["slapd"],
                                notify  => Service["slapd"]
                        }
		}

	}
	include ldap::utils
}

class ldap::phpldapadmin {
	include apache::server

	package { "phpldapadmin":
		ensure => installed,
		notify  => Service["apache2"]
	}

	package { "php5-mhash":
		ensure => installed,
		notify  => Service["apache2"]
	}
}

class ldap::pam {
	include ldap::client
	include ldap::nss

	package {"libpam-ldap": ensure => installed}

	file {["/etc/pam_ldap.conf", "/etc/ldap.conf"]:
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

class ldap::nslcd {
	case $lsbdistcodename {
		'karmic', 'lucid': {
			package {"nslcd": ensure => installed}
                        file {"/etc/nslcd.conf":
                                content => template("ldap/etc/nss-ldapd.conf")
                        }
		}
		default: {
                        file {"/etc/nss-ldapd.conf":
                                content => template("ldap/etc/nss-ldapd.conf"),
                                notify  => Service["nslcd"]
                        }
		}
	}

	service {"nslcd":
		ensure  => running,
		require => Package["libnss-ldapd"]
	}

}

class ldap::nss {
	include ldap::nslcd

	package {"libnss-ldapd": ensure => installed}

	file {"/etc/nsswitch.conf":
		content => template("ldap/etc/nsswitch.conf")
	}
}
