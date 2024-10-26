class Nene {

    const actitud
    const trajes = []
    const maquillajes = []
    var caramelos

    method capacidadParaAsustar() = self.sumatoriaDeSusto() * actitud

    method sumatoriaDeSusto() = (trajes+maquillajes).sum {unElemento => unElemento.nivelDeSusto()}

    method asustarA(unaPersona) {
        if(unaPersona.puedeAsustarsePor(self)) {
            unaPersona.darCaramelosA(self)
            unaPersona.agregarNinio(self)
        }
    }

    method agregarCaramelos(unaCantidad) {
        caramelos += unaCantidad
    }

    method caramelos() = caramelos

    method elementosUsados() = trajes+maquillajes

    method comerCaramelos(unaCantidad) {
        self.verificarTieneCaramelos(unaCantidad)

        caramelos =- unaCantidad
        
    }

    method verificarTieneCaramelos(unaCantidad) {
        if(! caramelos >= unaCantidad) {
            throw new DomainException(message = "No tenes suficientes caramelos")
        }
    }
        
}

class AdultoComun {

    var niniosQueLoAsustaron

    method puedeAsustarsePor(unNene) = self.tolerancia() < unNene.capacidadParaAsustar()


    method tolerancia() = 10 * niniosQueLoAsustaron

    method darCaramelosA(unNene) = unNene.agregarCaramelos(self.tolerancia() / 2)
        

    method aumentarNinios(unNene) {
        if(unNene.caramelos() > 15) {
            niniosQueLoAsustaron += 1
        }
    }
}

class Anciano inherits AdultoComun {

    override method puedeAsustarsePor(_unNene) = true

    override method darCaramelosA(unNene) = super(unNene) / 2
}

class AdultoNecio inherits AdultoComun {

   override method puedeAsustarsePor(_unNene) = false 
}