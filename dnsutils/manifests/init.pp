# Munin
# =====
#
# Installs the package dns-utils.
#
class dnsutils::client {
        package {"dnsutils": ensure => installed }
}
