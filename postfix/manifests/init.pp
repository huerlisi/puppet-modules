# Postfix
# =======
class postfix::server {
        package {"postfix": ensure => installed }
	package {"postfix-pcre": ensure => installed }

	service {"postfix":
		ensure  => running,
		require => Package["postfix"]
	}

	file {"/etc/postfix/main.cf":
		ensure  => present,
		content => template("postfix/etc/postfix/main.cf"),
		require => Package["postfix"],
		notify  => Service["postfix"]
	}
	file {"/etc/postfix/master.cf":
		ensure  => present,
		content => template("postfix/etc/postfix/master.cf"),
		require => Package["postfix"],
		notify  => Service["postfix"]
	}
}

class postfix::proxy {
	$postfix_mydestination = ''
	$postfix_mynetworks    = $friend_networks

	include server
}
