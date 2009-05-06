# Bind
# ====
class bind::server {
        package {"bind9": ensure => installed }

	# TODO: state check doesn't work
	service {"bind9":
		ensure  => running,
		require => Package["bind9"]
	}
}
