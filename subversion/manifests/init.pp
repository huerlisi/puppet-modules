# Subversion
# ==========
#
# Installs the package subversion.
#
class subversion::client {
        package {"subversion": ensure => installed}
}
