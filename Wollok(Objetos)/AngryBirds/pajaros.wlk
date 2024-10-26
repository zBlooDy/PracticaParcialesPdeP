import isla.*

class Pajaro {
    var ira = 0         // Si no no puedo hacer objetos de los pajaros, y hacer clases no tiene sentido

    method fuerza() = ira * 2

    method enojarse() {
        ira = ira * 2
    }

    method esFuerte() = self.fuerza() > 50

    method tranquilizarse(unaCantidad) {
        ira =- unaCantidad
    }

    method derriba(unObstaculo) {
        self.fuerza() > unObstaculo.resistencia()
    }

    method atacar(islaCerdita) {
        
    }
}

// Red y Terence tienen esta logica
class PajaroRencoroso inherits Pajaro {
    const multiplicador
    var cantidadVecesEnojado

    override method fuerza() = ira * multiplicador * cantidadVecesEnojado

    override method enojarse() {
        super()
        cantidadVecesEnojado += 1
    }
}

object bomb inherits Pajaro {
    const topeMaximoFuerza = 9000

    override method fuerza() = topeMaximoFuerza.min(super())
}

object chuck inherits Pajaro {
    var velocidad = 10

    override method fuerza() = self.calculoFuerza()

    method calculoFuerza() {
        if(velocidad <= 80) {
            return 150
        } else {
            return (velocidad - 80) * 5
        }
    }

    override method enojarse() {
        velocidad = velocidad * 2
    }

    override method tranquilizarse(_unaCantidad) {}
}

object matilda inherits Pajaro {

    const huevos = []

    override method fuerza() = super() + self.sumaFuerzaHuevos()

    method sumaFuerzaHuevos() = huevos.sum {unHuevo => unHuevo.peso()}

    override method enojarse() {
        huevos.add(new Huevo(peso = 2))
    }
}

class Huevo {
    const peso

    method peso() = peso
}
