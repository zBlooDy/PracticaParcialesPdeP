object islaPajaro {
    const pajaros = []

    method pajarosFuertes() = pajaros.filter {unPajaro => unPajaro.esFuerte()}

    method fuerzaIsla() = self.pajarosFuertes().sum {unPajaroFuerte => unPajaroFuerte.fuerza()}


    method sucedeEvento(unEvento) {
        pajaros.forEach {unPajaro => unEvento.afectaA(unPajaro)}
    }

    method atacarIslaCerdito() {
        pajaros.forEach {unPajaro => islaCerdita.recibirAtaqueDe(unPajaro)}
    }

    method seRecuperaronHuevos() = islaCerdita.quedoSinObstaculos()


    method incorporarUnPajaro(nuevoPajaro) {
        pajaros.add(nuevoPajaro)
    }

}

object islaCerdita {
    const obstaculos = []

    method primerObstaculo() = obstaculos.first()

    method recibirAtaqueDe(unPajaro) {
        if(!self.quedoSinObstaculos() and unPajaro.derriba(self.primerObstaculo())) {
            obstaculos.remove(self.primerObstaculo())
        }
    }

    method quedoSinObstaculos() = obstaculos.isEmpty()


}

