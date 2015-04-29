# GlusterFS
# =========
class glusterfs::server {
  package { "glusterfs-server": ensure => installed }

  file { "/srv/glusterfs": ensure => directory }

  mount { "/srv/glusterfs":
    ensure => mounted,
    atboot => true,
    fstype => "auto",
    options => "defaults",
    device => "/dev/vdb",
    require => File["/srv/glusterfs"]
  }
}

class glusterfs::client {
  package { "glusterfs-client": ensure => installed }
}
