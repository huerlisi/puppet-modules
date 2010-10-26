# OpenSSH
# =======
#
# Installs the package openssh-client.
#
class openssh::client {
	package {"openssh-client": ensure => installed }
}

#
# Installs the package openssh-server.
# Starts the service openssh-server.
#
class openssh::server {
	package {"openssh-server": ensure => installed }

	service {"ssh":
		ensure  => running,
		require => Package["openssh-server"]
	}
}
