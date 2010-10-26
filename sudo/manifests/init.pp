# Sudo
# ====
#
# Installs the package sudo.
# Adds the file /etc/sudoers with template sudo/etc/sudoers with mode 0440.
#
class sudo::client {
        package {"sudo": ensure => installed }

	file { "/etc/sudoers":
		content => template("sudo/etc/sudoers"),
		mode    => "0440",
		require => Package["sudo"]
	}
}
