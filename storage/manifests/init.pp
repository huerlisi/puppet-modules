# Storage
# =======
class storage::base {
	file { "/srv/$network/":
		ensure => directory
	}
}

define storage::srv() {
	include base
	file { "/srv/$network/$name":
		ensure  => directory,
		require => File["/srv/$network"]
	}
}

class storage::homes {
	srv { "home": }

	nfs::export { "/srv/$network/home": client => $network }
}
