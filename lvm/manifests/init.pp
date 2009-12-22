# LVM
# ===
class lvm::daemon {
	package { "lvm2": ensure => installed }
}

define lvm::device($volume, $group = $hostname, $size) {
	exec { "Create logical LVM device /dev/$group/$volume":
		path    => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command => "lvcreate --name $volume --size $size $group",
		creates => "/dev/$group/$volume"
	}
}
