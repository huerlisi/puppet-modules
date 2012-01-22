# SASL
# ====
class sasl::daemon {
	package {"sasl2-bin": ensure => installed }

	service {"saslauthd":
		ensure  => running,
		require => Package["sasl2-bin"]
	}
}
