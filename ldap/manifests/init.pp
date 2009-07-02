# LDAP
# ====
class ldap::server {
        package {"slapd": ensure => installed}

	service {"slapd":
		ensure  => running,
		require => Package["slapd"]
	}
}
