# Desktop
# =======
# Currently only KDE

class desktop::kde {
	package {"kde": ensure => installed}
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
}

