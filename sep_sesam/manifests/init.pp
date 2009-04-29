# SEP Sesam
# =========

class sep_sesam::client {
	# TODO: apt-get update
	file {"/etc/apt/sources.list.d/lenny-sep-sesam.list":
		ensure  => present,
		content => template("sep_sesam/etc/apt/sources.list.d/lenny-sep-sesam.list")
	}

	# TODO: unauthenticated package error...
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
