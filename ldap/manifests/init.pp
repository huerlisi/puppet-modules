# LDAP
# ====
class ldap::utils {
	package {"ldap-utils": ensure => installed}
}

class ldap::server {
        package {"slapd": ensure => installed}

	service {"slapd":
		ensure  => running,
		require => Package["slapd"]
	}

	include ldap::utils
}

