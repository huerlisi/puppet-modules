# DRBD
# ====
#
# Installs the packages drbd8-utils and drbd8-modules-$kernelrelease
# Starts the service drbd
# Adds the file /etc/drbd.d/00-common with content drbd/etc/drbd.d/common
# Checks if the directories /etc/drbd.d and /etc/drbd.d exists.
# Executes the Generating /etc/drbd.conf with the needed bin.
# Executes cat $(run-parts --list /etc/drbd.d) > /etc/drbd.conf
# Sets refreshonly to true.
# 
# Parameters
# $kernelrelease
# The actual release of the kernel. 
#
class drbd::daemon {
	package { "drbd8-utils": ensure => installed }
	package { "drbd8-modules-$kernelrelease": ensure => installed }

	service { "drbd": ensure => running }

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
		require     => [ File["/etc/drbd.d"], Package["drbd8-utils"] ],
#		notify      => Service["drbd"]
	}
}

#
# Adds the file /etc/drbd.d/$title with content drbd/etc/drbd.d/resource.conf.
# Checks if the directory /etc/drbd.d exists.
# Executes Generating /etc/drbd.conf.
# Executes drbdadm create-md $title; drbdadm up $title with the condition 
# drbdadm state $title | grep 'Unconfigured.
# Needs the package drbd8-utils and the file /etc/drbd.d.
# 
#
# Parameters
# $device
# Name of the device.
# $hostname
# Name of the host
# $ip
# IP of the host.
# $port
# ???Portnumber
# $disk
# ???
# $peer_device
# ???
# $peer_hostname
# ???
# $peer_ip
# ???
# $peer_port
# ???
# $peer_disk
# ???
# $title
# Name of the drbd file.
#
# Requires
# drbd::daemon
#
define drbd::resource($device, $hostname, $ip, $port, $disk, $peer_device = '', $peer_hostname, $peer_ip, $peer_port = '', $peer_disk = '') {
	include drbd::daemon

	file {"/etc/drbd.d/$title":
		ensure  => present,
		content => template("drbd/etc/drbd.d/resource.conf"),
		require => File["/etc/drbd.d"],
		notify  => Exec["Generating /etc/drbd.conf"]
	}

	exec { "Initializing DRBD resource $title":
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command     => "drbdadm create-md $title; drbdadm up $title",
		onlyif      => "drbdadm state $title | grep 'Unconfigured'",
		require     => [ File["/etc/drbd.d"], Package["drbd8-utils"] ],
	}
}
