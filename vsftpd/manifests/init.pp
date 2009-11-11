# VSFTP
# =====
class vsftpd::server {
	package {"vsftpd": ensure => installed }
	service {"vsftpd":
		ensure  => running,
		require => Package["vsftpd"]
	}

	file {"/etc/vsftpd.conf":
		content => template("vsftpd/etc/vsftpd.conf"),
		require => Package["vsftpd"],
		notify  => Service["vsftpd"]
	}

	# See Debian Bug 419856: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=419856
	file {"/etc/pam.d/vsftpd":
		content => template("vsftpd/etc/pam.d/vsftpd")
	}
}
