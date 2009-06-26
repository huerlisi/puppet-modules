# Proxy
# =====
class proxy::client {
	if $proxy_server_url {
		file {"/etc/environment":
			content => template("proxy/etc/environment")
		}
	}
}
