# ht://Dig
# ========
#
# Installs the package htdig.
# Adds the file /etc/htdig/htdig.conf with conten from htdig/etc/htdig/htdig.conf.
#
class htdig::daemon {
	package {"htdig": ensure => installed}

	file {"/etc/htdig/htdig.conf":
		ensure  => present,
		content => template("htdig/etc/htdig/htdig.conf"),
		require => Package["htdig"]
	}
}

#
# Defines htdig_instance with a individual path.
# Installs the package htdig.
#
# Parameters:
# $path
# Individual path for this instance
# $title
# Name of the instance.
#
define htdig_instance($path) {
	file {"/etc/htdig/htdig_$title.conf":
		require => Package["htdig"],
		ensure  => $path
	}
}
