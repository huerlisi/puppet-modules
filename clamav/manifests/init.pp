# Clamav
# ======
class clamav::daemon {
	include clamav::updater

        package {"clamav-daemon": ensure => installed }

	service {"clamav-daemon":
		ensure  => running,
		require => Package["clamav-daemon"],
		pattern => 'clamd'
	}
}

class clamav::updater {
        package {"clamav-freshclam": ensure => installed }

	service {"clamav-freshclam":
		ensure  => running,
		require => Package["clamav-freshclam"],
		pattern => 'freshclam'
	}
}

