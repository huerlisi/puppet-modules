# Locales
# =======
#
# Installs the package locales.
# Executes locale-gen from /etc/locale.gen.
# Adds the file /etc/locale.gen with content locales/etc/locale.gen.
#
class locales::conf {
        package { "locales": ensure => installed }

        exec { "locale-gen":
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command     => "locale-gen",
                refreshonly => true,
		subscribe   => File["/var/lib/locales/supported.d/puppet"],
		require     => Package["locales"]
        }

	file { "/var/lib/locales/supported.d/puppet":
		ensure  => file,
		content => template("locales/etc/locale.gen")
	}
}
