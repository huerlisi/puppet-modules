# Postfix
# =======
class postfix::server {
	include mail::mailname

        package {"postfix":
		ensure => installed,
		subscribe => File["/etc/mailname"]
	}
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

# Plugins
# =======
class postfix::ldap {
	include server
	
	package {"postfix-ldap": ensure => installed}
}

# Configurations
# ==============
class postfix::proxy {
	$postfix_mydestination = ''
	$postfix_mynetworks    = $friend_networks

	include server
}
