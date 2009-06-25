# Xen Tools
# =========
class xen::xen-tools {
        package { "xen-tools": ensure => installed }

        file { "/etc/xen-tools/xen-tools.conf":
                content => template('xen/etc/xen-tools/xen-tools.conf'),
                require => Package["xen-tools"]
        }

        file { "/etc/xen-tools/role.d/puppet":
                content => template('xen/etc/xen-tools/role.d/puppet'),
                require => Package["xen-tools"]
        }
}
