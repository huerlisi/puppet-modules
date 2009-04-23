# SEP Sesam
# =========

# TODO: add sesam repository
class sep_sesam::client {
	# TODO: unauthenticated package error...
	package {"sesam-cli": ensure => installed}

	# TODO: Add Service declaration, not now
	# as 'status' just starts in /etc/init.d/sesam
	file {"/var/opt/sesam/var/ini/sm_ctrld.auth":
		ensure  => present,
		content => template("sep_sesam/var/opt/sesam/var/ini/sm_ctrld.auth"),
		require => Package["sesam-cli"]
		# TODO: notify Service["sesam"]
	}
}
