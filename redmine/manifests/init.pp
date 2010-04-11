# Redmine
# =======
class redmine::webapp inherits rails::webapp {
	include mysql::server

	package {"redmine-mysql":
		ensure  => installed,
		require => Package["mysql-server"]
	}

	package {"redmine":
		ensure  => installed,
		require => Package["redmine-mysql"],
		notify  => Exec["Set www-data as owner of environment.rb"]
	}

	exec {"Set www-data as owner of environment.rb":
		command => "sudo dpkg-statoverride --update --add www-data root 644 /usr/share/redmine/config/environment.rb",
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
		refreshonly => true,
		notify      => Service["apache2"]
	}
}
