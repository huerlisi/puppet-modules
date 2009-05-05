# APT
# ===
class apt::unattended-upgrades {
	package {"unattended-upgrades": ensure => installed}
}
