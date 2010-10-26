# Proxy
# =====
#
# Adds the file /etc/environment with content proxy/etc/environment dependend 
# on $proxy_server_url
#
# Parameters
# $proxy_server_url
# ?
#
class proxy::client {
	if $proxy_server_url {
		file {"/etc/environment":
			content => template("proxy/etc/environment")
		}
	}
}
