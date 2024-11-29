// Escribir en este archivo

class Panelista {

    var puntosEstrellas

    method puntosEstrellas() = puntosEstrellas

    method darRemateSobre(unaTematica) 

    method incrementarPuntos(unaCantidad) {
        puntosEstrellas += unaCantidad
    }

    method opinarSobre(unaTematica) {
        unaTematica.afectarA(self)
    }


// Es la unica forma que se me ocurrio para no romper el encapsulamiento
// Cada clase va a saber que parametro tiene que usar

    method puntosPorDeportiva(unaCantidad, cantidadEspecial) {
        self.incrementarPuntos(unaCantidad)
    }

    method puntosPorFarandula(unaCantidad, cantidadEspecial) {
        self.incrementarPuntos(unaCantidad)
    }


    method tratar(unaTematica) {
        self.opinarSobre(unaTematica)
        self.darRemateSobre(unaTematica)
    }

}


class Celebridad inherits Panelista {

    override method darRemateSobre(_unaTematica) {
        self.incrementarPuntos(3)
    }


    override method puntosPorFarandula(unaCantidad, cantidadEspecial) {
        self.incrementarPuntos(cantidadEspecial)
    }
}

class Colorado inherits Panelista {

    var graciaActual

    override method darRemateSobre(_unaTematica) {
        self.incrementarPuntos(graciaActual / 5)
        self.aumentarGracia()
    }

    method aumentarGracia() {
        graciaActual += 1
    }
}

class ColoradoConPeluca inherits Colorado {

    override method darRemateSobre(_unaTematica) {
        super(_unaTematica)
        self.incrementarPuntos(1)
    }   
}

class Viejo inherits Panelista {

    override method darRemateSobre(unaTematica) {
        self.incrementarPuntos(unaTematica.cantidadPalabrasTitulo())
    }

}

class Deportivo inherits Panelista {

    override method darRemateSobre(_unaTematica) {
        //No suma puntos
    }

    override method puntosPorDeportiva(unaCantidad, cantidadEspecial) {
        self.incrementarPuntos(cantidadEspecial)
    }

}