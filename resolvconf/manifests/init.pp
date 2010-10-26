# Resolvconf
# ==========
#
# Installs the package resolvconf.
#
class resolvconf::client {
        package {"resolvconf": ensure => installed}
}
