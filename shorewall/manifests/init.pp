# Firewall
# ========
#
# Adds the following files with  content:
# /etc/shorewall/shorewall.conf content $shorewall_module/etc/shorewall/shorewall.conf.
# /etc/shorewall/interfaces content $shorewall_module/etc/shorewall/interfaces.
# /etc/shorewall/rules content $shorewall_module/etc/shorewall/rules.
# /etc/shorewall/masq content $shorewall_module/etc/shorewall/masq.
# /etc/shorewall/zones content $shorewall_module/etc/shorewall/zones.
# /etc/shorewall/policy content $shorewall_module/etc/shorewall/policy.
# /etc/shorewall/routestopped content $shorewall_module/etc/shorewall/routestopped.
#
# Parameters
# $shorewall_module
# Name of the shorewall module.
#
class shorewall::config {
	file { "/etc/shorewall/shorewall.conf":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/shorewall.conf")
	}

	file { "/etc/shorewall/interfaces":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/interfaces")
	}
	file { "/etc/shorewall/rules":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/rules")
	}
	file { "/etc/shorewall/masq":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/masq")
	}
	file { "/etc/shorewall/zones":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/zones")
	}
	file { "/etc/shorewall/policy":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/policy")
	}
	file { "/etc/shorewall/routestopped":
		ensure  => present,
		content => template("$shorewall_module/etc/shorewall/routestopped")
	}
}

#
# Installs the package shorewall-perl.
# Adds the file /etc/default/shorewall with content shorewall/etc/default/shorewall.
# If there is no shorewall module  $shorewall_module = 'shorewall'.
#
# Requires
#  shorewall::config
#
class shorewall::daemon {
	package { "shorewall-perl": ensure => installed }

	file { "/etc/default/shorewall":
		ensure  => present,
		content => template("shorewall/etc/default/shorewall")
	}

	if $shorewall_module {
		include shorewall::config
	} else {
		$shorewall_module = 'shorewall'
		include shorewall::config
	
	}
}
