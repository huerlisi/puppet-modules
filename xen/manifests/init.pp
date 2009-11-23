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
		'network-bridge': { include network::bridge }
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

# Configuration
# =============
define xen::instance(priority = '50') {
	file { "/etc/xen/auto/$priority-$title.cfg":
		ensure  => "/etc/xen/$title.cfg",
		require => File["/etc/xen/auto"]
	}
}

define xen::instance::config(xen_memory = '128', xen_disks = [], vifs = []) {
	file { "/etc/xen/$title.cfg":
		ensure  => present,
		content => template("xen/etc/xen/xend.cfg"),
		require => Package["xen-utils"]
	}
}

# DRBD
# ====
define xen::instance::drbd(priority = '50', disk_size = '4G', swap_size = '128M', drbd_disk_port, drbd_disk_device, drbd_swap_port, drbd_swap_device) {
	lvm::device {"$title-disk": size => $disk_size}
	xen::resource::drbd {"$title-disk":
		device => $drbd_disk_device,
		port   => $drbd_disk_port
	}

	lvm::device {"$title-swap": size => $swap_size}
	xen::resource::drbd {"$title-swap":
		device => $drbd_swap_device,
		port   => $drbd_swap_port
	}
}

define xen::resource::drbd(device, port) {
	drbd::resource { $title:
		device        => $device,
		hostname      => $hostname,
		ip            => $xen_ip,
		port          => $port,
		disk          => "/dev/$hostname/$title",
		peer_hostname => $xen_peer_hostname,
		peer_ip       => $xen_peer_ip,
		peer_disk     => "/dev/$xen_peer_hostname/$title"
	}
}
