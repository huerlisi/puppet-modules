# Resolvconf
# ==========
#
# Installs the package resolvconf.
#
class resolvconf::client {
  package {"resolvconf": ensure => installed}
  service {"resolvconf":
    ensure  => running,
    require => Package['resolvconf']
  }

  file {"/etc/resolvconf/resolv.conf.d/original":
    ensure  => present,
    content => '',
    notify  => Service['resolvconf']
  }
}
