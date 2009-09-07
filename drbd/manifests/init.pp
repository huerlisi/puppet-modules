# DRBD
# ====
class drbd::daemon {
	package { "drbd8-utils": ensure => installed }
	package { "drbd8-modules-2.6-xen-$architecture": ensure => installed }

	file {"/etc/drbd.d/00-common":
		ensure  => present,
		content => template("drbd/etc/drbd.d/common"),
		require => File["/etc/drbd.d"],
		notify  => Exec["Generating /etc/drbd.conf"]
	}

	file {"/etc/drbd.d": ensure  => directory}

	exec { "Generating /etc/drbd.conf":
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command     => "cat $(run-parts --list /etc/drbd.d) > /etc/drbd.conf",
		refreshonly => true,
		require     => File["/etc/drbd.d"]
	}

}

define drbd::resource(device, hostname, ip, port, disk, peer_device = '', peer_hostname, peer_ip, peer_port = '', peer_disk = '') {
	include drbd::daemon

	file {"/etc/drbd.d/$title":
		ensure  => present,
		content => template("drbd/etc/drbd.d/resource.conf"),
		require => File["/etc/drbd.d"],
		notify  => Exec["Generating /etc/drbd.conf"]
	}
}
