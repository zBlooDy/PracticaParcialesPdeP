import suscripciones.*

class Usuario {

    var dinero
    var humor
    var suscripcion

    method gastarDinero(unDinero) {
        dinero =- unDinero
    }

    method disminuirHumor(unaCantidad) {
        humor =- unaCantidad
    }

    method aumentarHumor(unaCantidad) {
        humor =+ unaCantidad
    }

    method pagarSuscripcion() {
        if (dinero < suscripcion.costo()) {
            self.suscripcion(prueba)
        }
    }

    method suscripcion(nuevaSuscripcion) {
        suscripcion = nuevaSuscripcion
    }

    method jugarA(unJuego, unasHoras) {
        if(suscripcion.puedeJugar(unJuego)) {
            unJuego.afectarA(self, unasHoras)
        }
        else {
            throw new DomainException (message = "Con esa suscripcion no podes pa :(")
        }
    }


}