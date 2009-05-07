# Resolvconf
# ==========
class resolvconf::client {
        package {"resolvconf": ensure => installed}
}
