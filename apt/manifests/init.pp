# APT
# ===
#
# Adds the file proxy to /etc/apt/apt.conf.d/ if the $proxy_server_url is true.
# Else it checks if the file is absent.
# Checks if /etc/apt/apt.conf.d/proxy-guess is absent.
# Adds the file /etc/apt/apt.conf.d/no-install-recommends with content.
#
# Parameters:
#  $proxy_server_url
#  URL of the proxy server.
#
class apt::client {
	if $proxy_server_url {
		file {"/etc/apt/apt.conf.d/proxy":
			content => template("apt/etc/apt/apt.conf.d/proxy")
		}
	} else {
		file {"/etc/apt/apt.conf.d/proxy": ensure => absent }
	}

	# proxy-guess ist configured by xen-tools
	file {"/etc/apt/apt.conf.d/proxy-guess": ensure => absent }

	file {"/etc/apt/apt.conf.d/no-install-recommends":
		content => template("apt/etc/apt/apt.conf.d/no-install-recommends")
	}

  package {["apticron", "apt-listchanges"]: ensure => purged }
  package {["unattended-upgrades"]: ensure => installed }
  file {"/etc/apt/apt.conf.d/02periodic":
		content => template("apt/etc/apt/apt.conf.d/02periodic")
  }
  file {"/etc/apt/apt.conf.d/50unattended-upgrades":
		content => template("apt/etc/apt/apt.conf.d/50unattended-upgrades")
  }
}

#
# Executes the update of the apt on the system.
#
class apt::update {
	exec { "apt-get update":
		path        => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		refreshonly => true,
		timeout     => "-1"
	}
}

#
# Adds the content to the repository file.
# Executes update of the system.
#
# Parameters:
#  $repository
#  Name of the repository.
#
#  $distro
#  Version of the distribution.
#
#  $lsbdistcodename
#  Defines the name of the new repository.
#
#  $components
#  Components included into the repository list.
#
#  $name.list
#  Name of the new repository list.
#
define apt::deb-list($repository, $distro = $lsbdistcodename, $components) {
	file { "/etc/apt/sources.list.d/$name.list":
		content => template("apt/etc/apt/sources.list.d/deb.list"),
		notify  => Exec["apt-get update"]
	}
}

# Ubuntu PPA
# ==========

#
# Installs the package python-software-properties.
#
class apt::ppa::utils {
	package {"python-software-properties": ensure => installed}
}

#
# Includes the classes apt::update and apt::ppa::utils.
# Add the repository with the execute task.
# Updates the repositories.
# Creates the source.list dile for the aditional repositories.
# Installs the package python-software-properties.
#
# Parameters:
#  $user
#  Defines the actual user which execute this class.
#
#  $repository
#  Defines the personal repositories.
#
#  $lsbdistcodename.list
#  Defines the name of the new repository.
#
define apt::ppa($user, $repository = 'ppa') {
	include apt::update
	include apt::ppa::utils

	exec { "Add PPA '$repository' for '$user'":
		path        => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		command     => "add-apt-repository ppa:$user/$repository",
		require     => Package["python-software-properties"],
		notify      => Exec["apt-get update"],
		creates     => "/etc/apt/sources.list.d/$user-$repository-$lsbdistcodename.list"
	}
}
