# SEP Sesam
# =========

# TODO: add sesam repository
class sep_sesam::client {
	# TODO: unauthenticated...
	package {"sesam-cli": ensure => installed}
}
