# Multipath
#
# Installs the package multipath-tools.
#
class multipath::daemon {
	package { 'multipath-tools': ensure => installed }
}
