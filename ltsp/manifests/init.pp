# LTSP
# ====
class ltsp::server {
	package {"ltsp-server-standalone": ensure => installed }

	exec {"ltsp-build-client --squashfs-image --late-packages xserver-xorg-video-geode":
		creates => "/opt/ltsp/i386",
		path    => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
		timeout => '-1'
	}
}
