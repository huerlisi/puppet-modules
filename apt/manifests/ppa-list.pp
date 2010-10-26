# CyT PPAs
# ========
#
# Imports zarafa from huerlisi-ppa.
#
class apt::ppa::huerlisi-ppa {
	# Ubuntu PPA for Simon Hürlimann
	import "zarafa"
	apt::ppa {"huerlisi-ppa": user => 'huerlisi'}
}
