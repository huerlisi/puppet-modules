# Firewall
# ========
class shorwall::base {
	package { "shorewall": ensure => installed }
}
