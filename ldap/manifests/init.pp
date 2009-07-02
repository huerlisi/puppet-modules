# LDAP
# ====
class ldap::utils {
	package {"ldap-utils": ensure => installed}

	file {"/etc/ldap/ldap.conf":
		ensure  => file,
		content => template("ldap/etc/ldap/ldap.conf"),
		require => Package["ldap-utils"]
	}
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

