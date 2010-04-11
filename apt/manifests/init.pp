# APT
# ===
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
}

class apt::update {
	exec { "apt-get update":
		path        => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		refreshonly => true,
		timeout     => "-1"
	}
}

class apt::unattended-upgrades {
	package {"unattended-upgrades": ensure => installed}
}

# Ubuntu PPA
# ==========
class apt::ppa::utils {
	package {"python-software-properties": ensure => installed}
}

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
