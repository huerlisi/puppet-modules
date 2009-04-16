# Firewall
# ========
class shorewall::base {
	package { "shorewall": ensure => installed }
}
