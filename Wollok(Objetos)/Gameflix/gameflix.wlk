import juegos.*
import suscripciones.*
import usuarios.*

object gameflix {
    const clientes = #{}
    const juegos = #{}

    method filtrarJuegosPor(unaCategoria) {
        juegos.filter({unJuego => unJuego.categoria() == unaCategoria})
    }

    method buscarJuegoSegun(nombreJuego) {
        const juegosPorNombre = juegos.map({unJuego => unJuego.nombre()})
    }

    method cobrarSuscripcion() {
        clientes.forEach({unCliente => unCliente.pagarSuscripcion()})
    }

    method recomendarAlAzar() {
        return juegos.anyOne()
    }
}