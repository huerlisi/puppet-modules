# NFS
# ===
class nfs::client {
        package {"nfs-common": ensure => installed }
}

class nfs::server {
        package {"nfs-kernel-server": ensure => installed }
}
