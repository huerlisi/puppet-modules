# Xen
# ===
class xen::tools {
        package { "xen-tools": ensure => installed }

        file { "/etc/xen-tools/xen-tools.conf":
                content => template('xen/etc/xen-tools/xen-tools.conf'),
                require => Package["xen-tools"]
        }
}

class xen::domU {
	service {"procps": ensure => running }

	file { "/etc/sysctl.d/50-xen-clocksource.conf":
		content => template('xen/etc/sysctl.d/50-xen-clocksource.conf'),
		notify  => Service['procps']
	}
}

class xen::dom0 {
        include xen::tools
        package { ["xen-utils", "xen-hypervisor-i386", "linux-image-xen-686"]: ensure => installed }

        service {"xend":
                ensure  => running,
                require => Package["xen-utils"]
        }

	case $xen_network_script {
		'network-bridge': { package {"bridge-utils": ensure => installed} }
	}

        file { "/etc/xen/xend-config.sxp":
                content => template("xen/etc/xen/xend-config.sxp"),
                require => Package["xen-utils"],
                notify  => Service["xend"]
        }

	# Workaround for Debian Bug #519064 (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=519064)
	file { ["/var/lib/xen/", "/var/lib/xen/save"]: ensure => directory }
}
