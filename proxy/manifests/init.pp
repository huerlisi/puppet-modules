# Proxy
# =====
class proxy::client {
	if $proxy_server_fqdn {
		file {"/etc/environment":
			content => template("proxy/etc/environment")
		}
	}
}
