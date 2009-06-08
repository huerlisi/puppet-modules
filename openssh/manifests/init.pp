# OpenSSH
# =======
class openssh::client {
	package {"openssh-client": ensure => installed }
}

class openssh::server {
	package {"openssh-server": ensure => installed }

	service {"ssh":
		ensure  => running,
		require => Package["openssh-server"]
	}
}
