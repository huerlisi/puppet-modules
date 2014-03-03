# CyT Bind
# ========
# Configure a DNS server using bind to provide internal and external name resolution.

class cyt_bind::server($type = 'slave') {
  $directory = '/etc/bind/zones.d'
  $master_ip = '77.109.141.213'

  $zones = $bind_zones

  include bind::server

  file { "/etc/bind/named.conf.local":
    content => template("cyt_bind/etc/bind/named.conf.local.erb"),
    notify  => Service["bind9"],
  }

	file {"/etc/bind/zones.d":
		ensure  => directory,
		require => Package["bind9"]
	}

  file { "/etc/bind/zones.cyt.ch":
    content => template("cyt_bind/etc/bind/zones.cyt.ch.erb"),
    notify  => Service["bind9"],
  }

  file { "/etc/bind/zones.clients":
    content => template("cyt_bind/etc/bind/zones.clients.erb"),
    notify  => Service["bind9"],
  }
}

