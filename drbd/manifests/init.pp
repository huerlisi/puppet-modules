# DRBD
# ====
class drbd::daemon {
	package { "drbd8-utils": ensure => installed }
	package { "drbd8-modules-2.6-xen-$architecture": ensure => installed }

	file {"/etc/drbd.conf":
		ensure  => present,
		content => template("drbd/etc/drbd.conf")
	}
}
