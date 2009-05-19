# Logrotate
# =========
class logrotate::daemon {
	package {"logrotate": ensure => installed }
}
