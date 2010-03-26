# NFS
# ===
class nfs::client {
        package {"nfs-common": ensure => installed }
}

class nfs::server {
        package {"nfs-kernel-server": ensure => installed }
	service {"nfs-kernel-server":
		ensure    => running,
		require   => Package["nfs-kernel-server"],
		hasstatus => true
	}
}

# Exports
define nfs::export($client) {
	include nfs::server
	augeas {"nfs export $name":
		context => "/files/etc/exports",
		changes => [
#			"defnode dir /files/etc/exports/dir[0] $name",
#			"set $dir/client '*'",
#			"set $dir/client/option[0] 'rw'",
#			"set $dir/client/option[0] 'sync'",
#			"set $dir/client/option[0] 'no_subtree_check'"

			"set dir[last() + 1] $name",
			"set dir[last()]/client '$client'",
			"set dir[last()]/client/option[0] 'rw'",
			"set dir[last()]/client/option[0] 'sync'",
			"set dir[last()]/client/option[0] 'no_subtree_check'"
		],
		onlyif  => "match dir[. = '$name'][./client = '$client'] size == 0",
		notify  => Service["nfs-kernel-server"]
	}
}
