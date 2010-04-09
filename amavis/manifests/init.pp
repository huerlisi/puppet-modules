# AMaViS
# ======
class amavis::daemon {
	include amavis::unpackers

        package {"amavisd-new": ensure => installed }

	service {"amavis":
		ensure  => running,
		require => Package["amavisd-new"]
	}

	file {"/etc/amavis/conf.d/50-user":
		ensure  => present,
		content => template("amavis/etc/amavis/conf.d/50-user"),
		notify  => Service["amavis"]
	}
}

# Anti-Spam
# =========
class amavis::spam {
	include daemon

	include spamassassin::daemon
	file {"/etc/amavis/conf.d/50-enable-spam-checks":
		ensure  => present,
		content => template("amavis/etc/amavis/conf.d/50-enable-spam-checks"),
		require => Package["amavisd-new"],
		notify  => Service["amavis"]
	}
}

# Anti-Virus
# ==========
class amavis::virus {
	include daemon

	include clamav::daemon
	user {"clamav":
		groups  => 'amavis',
		require => [Package["amavisd-new"], Package["clamav-daemon"]],
		notify  => Service["clamav-daemon"]
	}

	file {"/etc/amavis/conf.d/50-enable-virus-checks":
		ensure  => present,
		content => template("amavis/etc/amavis/conf.d/50-enable-virus-checks"),
		require => Package["amavisd-new"],
		notify  => Service["amavis"]
	}
}

# Unpack helpers
class amavis::unpackers {
	package {["bzip2", "lzop", "rpm", "binutils", "p7zip", "unrar-free", "ripole", "cabextract", "arj", "zoo", "arc"]: ensure => installed}
}
