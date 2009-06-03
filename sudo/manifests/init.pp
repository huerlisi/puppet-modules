# Sudo
# ====
class sudo::client {
        package {"sudo": ensure => installed }

	file { "/etc/sudoers":
		content => template("sudo/etc/sudoers"),
		mode    => "0440",
		require => Package["sudo"]
	}
}
