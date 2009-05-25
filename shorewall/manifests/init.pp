# Firewall
# ========
class shorewall::daemon {
	package { "shorewall-perl": ensure => installed }

	file { "/etc/shorewall/shorewall.conf":
		ensure  => present,
		content => template("shorewall/etc/shorewall/shorewall.conf")
	}
}
