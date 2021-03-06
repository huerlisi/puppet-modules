# KVM
# ======
#
# Enables remote access on a virtual kvm host with local console.
#
class kvm::console {
	file {"/etc/init/ttyS0.conf":
                ensure => present,
                mode => "0640",   
                owner => "root",  
                content => template("kvm/etc/init/ttyS0.conf"),
	}
}

class kvm::guest {
	include kvm::console
}

class kvm::host {
	package { ['qemu-kvm', 'libvirt-bin']: ensure => installed }
}
