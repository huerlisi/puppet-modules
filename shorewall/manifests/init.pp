# Firewall
# ========
class shorewall::daemon {
	package { "shorewall-perl": ensure => installed }

	file { "/etc/default/shorewall":
		ensure  => present,
		content => template("shorewall/etc/default/shorewall")
	}

	file { "/etc/shorewall/shorewall.conf":
		ensure  => present,
		content => template("shorewall/etc/shorewall/shorewall.conf")
	}

	file { "/etc/shorewall/interfaces":
		ensure  => present,
		content => template("shorewall/etc/shorewall/interfaces")
	}
	file { "/etc/shorewall/rules":
		ensure  => present,
		content => template("shorewall/etc/shorewall/rules")
	}
	file { "/etc/shorewall/masq":
		ensure  => present,
		content => template("shorewall/etc/shorewall/masq")
	}
	file { "/etc/shorewall/zones":
		ensure  => present,
		content => template("shorewall/etc/shorewall/zones")
	}
	file { "/etc/shorewall/policy":
		ensure  => present,
		content => template("shorewall/etc/shorewall/policy")
	}
	file { "/etc/shorewall/routestopped":
		ensure  => present,
		content => template("shorewall/etc/shorewall/routestopped")
	}
}
