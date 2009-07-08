# DHCP
# ====
class dhcp::server {
        package { "dhcp3-server": ensure => installed }

        service { "dhcp3-server":
                ensure => running,
                require => Package["dhcp3-server"]
        }
}
