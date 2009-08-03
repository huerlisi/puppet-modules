# ht://Dig
# ========
class htdig::daemon {
	package {"htdig": ensure => installed}

	file {"/etc/htdig/htdig.conf":
		ensure  => present,
		content => template("htdig/etc/htdig/htdig.conf"),
		require => Package["htdig"]
	}
}

define htdig_instance($path) {
	file {"/etc/htdig/htdig_$title.conf":
		require => Package["htdig"],
		ensure  => $path
	}
}
