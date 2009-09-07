# Xen
# ===
class xen::domU {
	service {"procps": alias => sysctl}

	case $lsbdistcodename {
		'hardy': {}
		default: {
			file { "/etc/sysctl.d/50-xen-clocksource.conf":
				content => template('xen/etc/sysctl.d/50-xen-clocksource.conf'),
				notify  => Service['procps']
			}
		}
	}
}

class xen::dom0 {
        include xen-tools
        package { "xen-utils": ensure => installed }
	case $architecture {
		"i686":  { package { ["xen-hypervisor-i386", "linux-image-xen-686"]: ensure => installed } }
		"amd64": { package { ["xen-hypervisor", "linux-image-xen-amd64"]: ensure => installed } }
	}

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

	file { "/etc/xen/auto":
		ensure  => directory,
		require => Package["xen-utils"]
	}

	# Workaround for Debian Bug #519064 (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=519064)
	file { ["/var/lib/xen/", "/var/lib/xen/save"]: ensure => directory }
}

define xen::instance(priority = '50') {
	file { "/etc/xen/auto/$priority-$title.cfg":
		ensure  => "/etc/xen/$title.cfg",
		require => File["/etc/xen/auto"]
	}
}
