# AMaViS
# ======
#
# Add the service amavis and write content into /etc/amavis/conf.d/50-user.
# Install the package amavisd-new and ensure the service amavis will run.
# 
# Requires
#  amavis::unpackers
#
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
#
# Write content into amavis/etc/amavis/conf.d/50-enable-spam-checks.
# Checks if the package amavisd-new is installed and the service amavis is running.
#
# Requires:
#  daemon
#  spamassassin::daemon
#
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
#
# Creats user clamav with groupname amavis.
# Installs the packages amavisd-new and clamav-daemon.
# Check if the services clamav-daemon and amavis are running.
# Creates the file /etc/amavis/conf.d/50-enable-virus-checks.
#
# Requires:
#  daemon
#  clamav::daemon
#
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
#
# Install packages bzip2, lzop, rpm, binutils, p7zip, unrar-free, ripole, cabextract, arj, zoo and arc
#
class amavis::unpackers {
	package {["bzip2", "lzop", "rpm", "binutils", "p7zip", "unrar-free", "ripole", "cabextract", "arj", "zoo", "arc"]: ensure => installed}
}