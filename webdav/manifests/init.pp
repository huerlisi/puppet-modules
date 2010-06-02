# WebDAV
# ======

# Configures Apache2 to provide WebDAV.
#
# Depends on:
#   - apache2

class webdav::apache2 {
	include apache2::server
        apache2::module { ["dav.load", "dav_fs.conf", "dav_fs.load"]: }
}
