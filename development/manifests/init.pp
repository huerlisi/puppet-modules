# Development
# ===========
class development::utils {
	package {"bzr": ensure => installed}
	package {"git-core": ensure => installed}
}

class development::debian {
	package {["dput", "devscripts", "fakeroot", "build-essential"]: ensure => installed}
}

class development::ubuntu inherits development::debian {
	package {["wget", "ubuntu-dev-tools"]: ensure => installed}
}
