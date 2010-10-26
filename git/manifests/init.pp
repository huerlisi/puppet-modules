# Git
# ===
#
# Installs the package git-core.
#
class git::client {
	package { "git-core": ensure => installed }
}
