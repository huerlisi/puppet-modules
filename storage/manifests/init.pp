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

	include nfs::server
	augeas {"nfs export homes":
		context => "/files/etc/exports",
		changes => [
#			"defnode dir /files/etc/exports/dir[0] /srv/$network/home",
#			"set $dir/client '*'",
#			"set $dir/client/option[0] 'rw'",
#			"set $dir/client/option[0] 'sync'",
#			"set $dir/client/option[0] 'no_subtree_check'"
			"set dir[last() + 1] /srv/$network/home",
			"set dir[last()]/client '*'",
			"set dir[last()]/client/option[0] 'rw'",
			"set dir[last()]/client/option[0] 'sync'",
			"set dir[last()]/client/option[0] 'no_subtree_check'"
		],
		onlyif  => "match dir[. ='/srv/$network/home'] size == 0",
		notify  => Service["nfs-kernel-server"]
	}
}
