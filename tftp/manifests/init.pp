# TFTP
# ====
#
# Installs the package tftpd-hpa.
# Starts the service tftpd-hpa with pattern /usr/sbin/in.tftpd.
# Adds the file /etc/default/tftpd-hpa with content tftp/etc/default/tftpd-hpa.
#
class tftp::server {
        package { "tftpd-hpa": ensure => installed }

        service { "tftpd-hpa":
                ensure => running,
                require => Package["tftpd-hpa"],
		pattern => '/usr/sbin/in.tftpd'
        }

	file { "/etc/default/tftpd-hpa":
		ensure  => file,
		content => template("tftp/etc/default/tftpd-hpa"),
		require => Package["tftpd-hpa"],
		notify  => Service["tftpd-hpa"]
	}
}
