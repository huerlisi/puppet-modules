# Obnam Backup

class obnam::server {
  user { 'obnam':
    ensure => present,
    comment => 'Obnam Backup',
    home    => '/srv/backups',
    password => '*'
  }
}

class obnam::client($repository, $id_rsa = undef, $known_hosts = undef, $excludes = []) {
  package { 'obnam': ensure => installed }

  file { '/etc/obnam': ensure => directory }

  # Configuration and profiles
  file { '/etc/obnam/00-system.conf':
    content => template('obnam/etc/obnam/00-system.conf.erb'),
    require => File['/etc/obnam']
  }
  file { '/etc/obnam/host.profile':
    content => template('obnam/etc/obnam/host.profile.erb'),
    require => File['/etc/obnam']
  }

  # Authorization
  if $id_rsa {
    file { '/etc/obnam/id_rsa.obnam':
      content => $id_rsa,
      mode    => '0600',
      require => File['/etc/obnam']
    }
  }
  if $known_hosts {
    file { '/etc/obnam/known_hosts':
      content => $known_hosts,
      require => File['/etc/obnam']
    }
  }

  # Scheduler
  $cron_minute = fqdn_rand(60)
  $cron_hour = fqdn_rand(8)

  file { '/etc/cron.d/obnam-host':
    content => template('obnam/etc/cron.d/obnam-host.erb'),
    require => File['/etc/obnam']
  }
}
