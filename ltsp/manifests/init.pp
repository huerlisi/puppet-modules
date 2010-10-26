# LTSP
# ====
#
# Installs the package ltsp-server-standalone.
# Executes ltsp-build-client --squashfs-image --late-packages xserver-xorg-video-geode.
# Creates /opt/ltsp/i386 with path from bin.
#
# Requires
# desktop::ltsp
#
class ltsp::server {
	package {"ltsp-server-standalone": ensure => installed }

	exec {"ltsp-build-client --squashfs-image --late-packages xserver-xorg-video-geode":
		creates => "/opt/ltsp/i386",
		path    => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
		timeout => '-1'
	}

	include desktop::ltsp
}
