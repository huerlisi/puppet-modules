# LVM
# ===
class lvm::daemon {
	package { "lvm2": ensure => installed }
}

define lvm::device(group = $hostname, size) {
	exec { "Create logical LVM device /dev/$group/$title":
		path    => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command => "lvcreate --name $title --size $size $group",
		creates => "/dev/$group/$title"
	}
}
