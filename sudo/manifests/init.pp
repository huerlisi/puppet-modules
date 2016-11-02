# Sudo
# ====
#
# Installs the package sudo.
#
class sudo::client {
  package {"sudo": ensure => installed }

	file { "/etc/sudoers.d/sysadmins":
		content => template("sudo/etc/sudoers.d/sysadmins"),
		mode    => "0440",
		require => Package["sudo"]
	}
}
