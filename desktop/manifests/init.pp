# Desktop
# =======
# Currently only KDE

#
# Installs the packages kde and kde-i18n-de.
#
class desktop::kde {
	package {["kde", "kde-i18n-de"]: ensure => installed}
}

class desktop::office {

}

#
# Requires:
#  desktop::kde
#
class desktop::laptop {
	include desktop::kde
}

#
# Requires:
#  desktop::kde
#
class desktop::netbook {
	include desktop::kde
}

#
# Installs the packages openoffice.org, openoffice.org-help-de,
# openoffice.org-hyphenation-de, openoffice.org-kde, openoffice.org-l10n-de, 
# openoffice.org-thesaurus-de-ch, iceweasel, iceweasel-l10n-de, konversation,
# icedove, icedove-l10n-de, wine, msttcorefonts, flashplugin-nonfree, 
# freenx-server, xkb-data, expect, tcl8.4, dbus-x11, libxcomp3, libxcompext3
# libxcompshad3, nxlibs, nxagent, nxproxy, nxclient, sun-java6-plugin, encfs
# luma and speedcrunch 
#
# Requires
#  ldap::utils
#
class desktop::ltsp {
	include desktop::kde
        package {["openoffice.org", "openoffice.org-help-de", "openoffice.org-hyphenation-de", "openoffice.org-kde", "openoffice.org-l10n-de", "openoffice.org-thesaurus-de-ch"]: ensure => installed}
        package {["iceweasel", "iceweasel-l10n-de"]: ensure => installed}
        package {"konversation": ensure => installed}
	package {["icedove", "icedove-l10n-de"]: ensure => installed}
        package {["wine", "msttcorefonts"]: ensure => installed}
	package {"flashplugin-nonfree": ensure => installed}
	package {["freenx-server", "xkb-data", "expect", "tcl8.4", "dbus-x11", "libxcomp3", "libxcompext3", "libxcompshad3", "nxlibs", "nxagent", "nxproxy", "nxclient"]: ensure => installed}
	package {"sun-java6-plugin": ensure => installed}
	package {"encfs": ensure => installed}
	package {"luma": ensure => installed}
	package {"speedcrunch": ensure => installed}
	include ldap::utils
}

