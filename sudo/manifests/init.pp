# Sudo
# ====
class sudo::client {
        package {"sudo": ensure => installed }

        exec { "Allow ALL to group %ita":
                command => "/bin/echo '%ita ALL=(ALL) ALL' >>/etc/sudoers",
                unless  => "/bin/grep '%ita ALL=(ALL) ALL' /etc/sudoers",
                require => Package["sudo"]
        }
}
