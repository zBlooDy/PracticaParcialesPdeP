import jugadores.*

class Tarea {
    const itemsNecesarios = []

    method puedeRealizarla(unTripulante) = itemsNecesarios.all {unItem => unTripulante.tiene(unItem)}

    method realizatePor(unTripulante) {
        self.afectarA(unTripulante)
        unTripulante.usarItems(itemsNecesarios)
    }

    method afectarA(unTripulante)
}

class ArreglarTablero inherits Tarea(itemsNecesarios = [llaveInglesa]) {

    override method afectarA(unTripulante) {
        unTripulante.aumentarSospecha(10)
    }
}

class SacarBasura inherits Tarea(itemsNecesarios = [escoba, bolsaConsorcio]) {

    override method afectarA(unTripulante) {
        unTripulante.disminuirSospecha(4)
    }
}


class VentilarNave inherits Tarea(itemsNecesarios = []) {

    override method afectarA(unTripulante) {
        nave.aumentarOxigeno(5)
    }
}



class Item {
    const nombre

    method nombre() = nombre
}

const llaveInglesa   = new Item(nombre = "Llave inglesa")
const escoba         = new Item(nombre = "Escoba")
const bolsaConsorcio = new Item(nombre = "Bolsa de consorcio")