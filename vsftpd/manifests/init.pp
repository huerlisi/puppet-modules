# VSFTP
# =====
#
# Installs the package vsftpd.
# Starts the service vsftpd.
# Adds the file /etc/vsftpd.conf with content vsftpd/etc/vsftpd.conf.
# Ads the file /etc/pam.d/vsftpd with content vsftpd/etc/pam.d/vsftpd.
#
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
