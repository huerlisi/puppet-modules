# LVM
# ===
#
# Installs the package lvm2
#
class lvm::daemon {
	package { "lvm2": ensure => installed }
}

#
# Executes Create logical LVM device /dev/$group/$volume with path of bin.
# Executes lvcreate --name $volume --size $size $group.
# Creates /dev/$group/$volume.
#
# Parameters
# $volume
# Name of the device.
# $group
# Name of the Domain Group.
# $hostname
# Name of the host.
# $size
# Size of the host.
#
define lvm::device($volume, $group = $hostname, $size) {
	exec { "Create logical LVM device /dev/$group/$volume":
		path    => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command => "lvcreate --name $volume --size $size $group",
		creates => "/dev/$group/$volume"
	}
}
