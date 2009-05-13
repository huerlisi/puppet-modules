# Firewall
# ========
class shorewall::daemon {
	package { "shorewall-perl": ensure => installed }
}
