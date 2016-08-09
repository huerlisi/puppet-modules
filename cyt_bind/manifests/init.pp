# CyT Bind
# ========
# Configure a DNS server using bind to provide internal and external name resolution.

class cyt_bind::server {
  $directory = '/etc/bind/zones.d'

  $type = $bind_type

  $master_ip = $bind_master_ip
  $slave_ips = $bind_slave_ips

  $custom_zones = $bind_custom_zones
  $basic_zones = $bind_basic_zones

  $internal_master_ip = $bind_internal_master_ip
  $internal_slave_ips = $bind_internal_slave_ips
  $internal_zones = $bind_internal_zones

  include bind::server

  file { "/etc/bind/named.conf.local":
    content => template("cyt_bind/etc/bind/named.conf.local.erb"),
    notify  => Service["bind9"],
  }

	file {"/etc/bind/zones.d":
		ensure  => directory,
		require => Package["bind9"]
	}

  file { "/etc/bind/zones.custom":
    content => template("cyt_bind/etc/bind/zones.custom.erb"),
    notify  => Service["bind9"],
  }

  file { "/etc/bind/zones.basic":
    content => template("cyt_bind/etc/bind/zones.basic.erb"),
    notify  => Service["bind9"],
  }

  file { "/etc/bind/zones.internal":
    content => template("cyt_bind/etc/bind/zones.internal.erb"),
    notify  => Service["bind9"],
  }
}

