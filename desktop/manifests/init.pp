# Desktop
# =======
# Currently only KDE

class desktop::kde {
	package {["kde", "kde-i18n-de"]: ensure => installed}
}

class desktop::office {

}

class desktop::laptop {
	include desktop::kde
}

class desktop::netbook {
	include desktop::kde
}

class desktop::ltsp {
	include desktop::kde
        package {["openoffice.org", "openoffice.org-help-de", "openoffice.org-hyphenation-de", "openoffice.org-kde", "openoffice.org-l10n-de", "openoffice.org-thesaurus-de-ch"]: ensure => installed}
        package {["iceweasel", "iceweasel-l10n-de"]: ensure => installed}
        package {"konversation": ensure => installed}
	package {["icedove", "icedove-l10n-de"]: ensure => installed}
        package {["wine", "msttcorefonts"]: ensure => installed}
	package {"flashplugin-nonfree": ensure => installed}
	package {["freenx-server", "xkb-data", "expect", "tcl8.4", "dbus-x11", "libxcomp3", "libxcompext3", "libxcompshad3", "nxlibs", "nxagent", "nxproxy", "nxclient"]: ensure => installed}

	package {"luma": ensure => installed}
	include ldap::utils
}

