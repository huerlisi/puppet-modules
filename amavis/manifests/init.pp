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
		content => template("amavis//etc/amavis/conf.d/50-user"),
		notify  => Service["amavis"]
	}
}

# Anti-Spam
# =========
class amavis::spam {
	file {"/etc/amavis/conf.d/50-enable-spam-checks":
		ensure  => present,
		content => template("amavis//etc/amavis/conf.d/50-enable-spam-checks"),
		notify  => Service["amavis"]
	}
}

# Anti-Virus
# ==========
class amavis::virus {
	# TODO: add group clamav to amavis
	file {"/etc/amavis/conf.d/50-enable-virus-checks":
		ensure  => present,
		content => template("amavis//etc/amavis/conf.d/50-enable-virus-checks"),
		notify  => Service["amavis"]
	}
}

# Unpack helpers
class amavis::unpackers {
	package {["bzip2", "lzop", "rpm", "binutils", "p7zip", "rar", "ripole", "cabextract", "arj", "zoo", "lha"]: ensure => installed}
}
