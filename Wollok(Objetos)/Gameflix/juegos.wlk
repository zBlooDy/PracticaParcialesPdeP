import suscripciones.*

class Juego {
    const categoria
    const precio
    const nombre

    method nombre() {
        return nombre
    }

    method categoria() {
        return categoria
    }

    method precio() {
        return precio
    }

    method afectarA(unCliente, unasHoras)



}

class JuegoViolento inherits Juego {


    override method afectarA(unCliente, unasHoras) {
        unCliente.disminuirHumor(10 * unasHoras)
    }
}

class JuegoMoba inherits Juego {

    override method afectarA(unCliente, _unasHoras) {
        unCliente.gastarDinero(30)
    }
}

class JuegoTerror inherits Juego {
    
    override method afectarA(unCliente, _unasHoras) {
        unCliente.cambiarSuscripcion(infantil)
    }
}

class JuegoEstrategico inherits Juego {

    override method afectarA(unCliente, unasHoras) {
        unCliente.aumentarHumor(5 * unasHoras)
    }
}