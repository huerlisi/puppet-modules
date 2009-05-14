# Postfix
# =======
class postfix::server {
        package {"postfix": ensure => installed }

	service {"postfix":
		ensure  => running,
		require => Package["postfix"]
	}
}

