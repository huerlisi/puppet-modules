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
