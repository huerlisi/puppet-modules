# TFTP
# ====
class tftp::server {
        package { "tftpd-hpa": ensure => installed }

        service { "tftpd-hpa":
                ensure => running,
                require => Package["tftpd-hpa"],
		pattern => 'in.tftpd'
        }

	file { "/etc/default/tftpd-hpa":
		ensure  => file,
		content => template("tftp/etc/default/tftpd-hpa"),
		require => Package["tftpd-hpa"],
		notify  => Service["tftpd-hpa"]
	}
}
