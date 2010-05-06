# Development
# ===========
class development::utils {
	package {"bzr": ensure => installed}
	package {"git-core": ensure => installed}
}
