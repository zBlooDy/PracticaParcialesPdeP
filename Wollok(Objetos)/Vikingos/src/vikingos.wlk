class Vikingo {
    
    var casta
    var monedas

    method esProductivo()

    method puedeSubir() = casta.permiteSubir() || self.esProductivo()

    method subirA(unaExpedicion) {
        if(self.puedeSubir()) {
            unaExpedicion.agregarVikingo(self)
        } else {
            throw new DomainException(message = "No se puede subir a la expedicion :(")
        }
    }

    method valeLaPena(unaExpedicion) = unaExpedicion.tieneUnGranBotin()

    // O.o
    method ascenderAlValhalla() {
        casta.ascenderPor(self)
    }

    method casta(nuevaCasta) {
        casta = nuevaCasta
    }

    method agregarMonedas(unaCantidad) {
        monedas += unaCantidad
    }
}

class Soldado inherits Vikingo {

    var armas
    var vidasCobradas

    override method esProductivo() = self.tieneArmas() && self.matoMucho()

    method tieneArmas() = armas != 0

    method matoMucho() = vidasCobradas > 20


    method cobrarUnaVida() {
        vidasCobradas += 1
    }

    method recompensa() {
        armas += 10
    }
}

class Granjero inherits Vikingo {
    var hectareas
    var hijos

    override method esProductivo() = hectareas/hijos > 2 //creo q es asi la cuenta

    method cobrarUnaVida() {}

    method tieneArmas() = false 

    method recompensa() {
        hectareas += 2
        hijos += 2
    }
} 