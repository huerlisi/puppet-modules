# Postfix
# =======
class postfix::server {
        package {"postfix": ensure => installed }

	service {"postfix":
		ensure  => running,
		require => Package["postfix"]
	}

	file {"/etc/postfix/main.cf":
		ensure  => present,
		content => template("postfix/etc/postfix/main.cf"),
		notify  => Service["postfix"]
	}
}

