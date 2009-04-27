# VSFTP
# =====
class vsftpd::server {
	package {"vsftpd": ensure => installed }
	service {"vsftpd":
		ensure  => running,
		require => Package["vsftpd"]
	}
}
