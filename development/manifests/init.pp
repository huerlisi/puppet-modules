# Development
# ===========
#
# Installs the packages bzr and git-core.
#
class development::utils {
	package {"bzr": ensure => installed}
	package {"git-core": ensure => installed}
}

#
# Installs the packages dput, devscripts, fakeroot and build-essential.
#
class development::debian {
	package {["dput", "devscripts", "fakeroot", "build-essential"]: ensure => installed}
}

#
# Installs the packages wget and ubuntu-dev-tools.
#
# Includes development::debian
#
class development::ubuntu inherits development::debian {
	package {["wget", "ubuntu-dev-tools"]: ensure => installed}
}
