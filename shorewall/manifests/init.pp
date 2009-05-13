# Firewall
# ========
class shorewall::daemon {
	package { "shorewall": ensure => installed }
}
