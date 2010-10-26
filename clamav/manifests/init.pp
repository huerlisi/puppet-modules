# Clamav
# ======
#
# Installs package clamav-daemon.
# Starts the service clamav-daemon with pattern clamd
#
# Requires:
# clamav::updater
#
class clamav::daemon {
	include clamav::updater

        package {"clamav-daemon": ensure => installed }

	service {"clamav-daemon":
		ensure  => running,
		require => Package["clamav-daemon"],
		pattern => 'clamd'
	}
}
#
# Installs the package clamav-freshclam.
# Starts the service clamav-freshclam with the pattern freshclam.
#
class clamav::updater {
        package {"clamav-freshclam": ensure => installed }

	service {"clamav-freshclam":
		ensure  => running,
		require => Package["clamav-freshclam"],
		pattern => 'freshclam'
	}
}

