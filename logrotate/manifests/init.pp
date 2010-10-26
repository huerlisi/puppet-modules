# Logrotate
# =========
#
# Installs the package lograte.
#
class logrotate::daemon {
	package {"logrotate": ensure => installed }
}
