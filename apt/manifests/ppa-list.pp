# CyT PPAs
# ========
class apt::ppa::huerlisi-ppa {
	# Ubuntu PPA for Simon Hürlimann
	import "zarafa"
	apt::ppa {"huerlisi-ppa": user => 'huerlisi'}
}
