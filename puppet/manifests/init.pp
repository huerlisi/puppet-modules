# Puppet
# ======
class puppet::server {
    package { "puppetmaster": ensure => installed }
    service { "puppetmaster": ensure => running }

#    file { "/etc/puppet/fileserver.conf":
#            ensure  => file,
#            content => template('puppet/etc/puppet/fileserver.conf')
#    }

    file {
        ["/etc/puppet/manifests", "/etc/puppet/manifests/nodes", "/etc/puppet/modules"]:
            ensure => directory,
            mode   => "2775",
            owner  => "root",
#            group  => "cyt-sysadmins"
    }

    file { "/etc/puppet/modules/*":
        mode => "2775",
        owner => "root",
#        group => "cyt-sysadmins"
    }
}
