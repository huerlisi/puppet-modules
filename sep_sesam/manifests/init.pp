# SEP Sesam
# =========

#
# Adds the file /etc/apt/sources.list.d/lenny-sep-sesam.list with content
# sep_sesam/etc/apt/sources.list.d/lenny-sep-sesam.list.
# Executes apt-get update.
# Installs the package sesam-cli
# Adds the file /var/opt/sesam/var/ini/sm_ctrld.auth with content 
# sep_sesam/var/opt/sesam/var/ini/sm_ctrld.auth.
#
# Requires
# apt::update
#
class sep_sesam::client {
	# TODO: apt-get update
	file {"/etc/apt/sources.list.d/lenny-sep-sesam.list":
		ensure  => present,
		content => template("sep_sesam/etc/apt/sources.list.d/lenny-sep-sesam.list"),
		notify  => Exec["apt-get update"]
	}

	# TODO: unauthenticated package error...
	include apt::update
	package {"sesam-cli":
		ensure  => installed,
		require => File["/etc/apt/sources.list.d/lenny-sep-sesam.list"]
	}

	# TODO: Add Service declaration, not now
	# as 'status' just starts in /etc/init.d/sesam
	file {"/var/opt/sesam/var/ini/sm_ctrld.auth":
		ensure  => present,
		content => template("sep_sesam/var/opt/sesam/var/ini/sm_ctrld.auth"),
		require => Package["sesam-cli"]
		# TODO: notify Service["sesam"]
	}
}
