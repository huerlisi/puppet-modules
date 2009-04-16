# Xen
# ===
class xen::tools {
        package { "xen-tools": ensure => installed }

        file { "/etc/xen-tools/xen-tools.conf":
                content => template('xen/etc/xen-tools/xen-tools.conf'),
                require => Package["xen-tools"]
        }
}

class xen::dom0 {
        include xen::tools
        package { ["xen-utils-common", "xen-hypervisor-i386", "linux-image-xen-686"]: ensure => installed }

        service {"xend":
                ensure  => running,
                require => Package["xen-utils-common"]
        }

        file { "/etc/xen/xend-config.sxp":
                content => template("xen/etc/xen/xend-config.sxp"),
                require => Package["xen-utils-common"],
                notify  => Service["xend"]
        }
}
