class Escapista {

    var maestria
    const salasEscapadas = []
    var dinero

    method puedeSalirDe(unaSala) = maestria.puedeSalir(unaSala, self)

    method hizoMuchasSalas() = salasEscapadas.size() >= 6

    method subirMaestria() {
        maestria = maestria.evolucionar()
    }

    method nombreSalasEscapadas() = salasEscapadas.map {unaSala => unaSala.nombre()}.asSet()

    method agregarSala(unaSala) {
        salasEscapadas.add(unaSala)
    }

    method puedePagar(unPrecio) = dinero >= unPrecio

    method pagar(unPrecio) {
        dinero =- unPrecio
    }
}

class GrupoEscapistas {
    const escapistas

    method puedenSalirDe(unaSala) = escapistas.any {unEscapista => unEscapista.puedeSalir(unaSala, unEscapista)}

    method escapar(unaSala) {
        self.verificarSiPuedenPagar(unaSala)
        self.pagar(unaSala)
        self.agregarSiEscapan(unaSala)
    }

    method agregarSiEscapan(unaSala) {
        if(self.puedenSalirDe(unaSala)) {
            escapistas.forEach {unEscapista => unEscapista.agregarSala(unaSala)}
        }
    }

    method verificarSiPuedenPagar(unaSala) {
        if(!self.puedenPagar(unaSala)) {
            throw new DomainException(message = "No pueden pagar la sala, arafue")
        }
    }

    method puedenPagar(unaSala) = self.todosPuedenPagar(self.precioSalaPorGrupo(unaSala)) or self.sumaDeSaldosCubre(self.precioSalaPorGrupo(unaSala))

    method precioSalaPorGrupo(unaSala) = unaSala.precio() / escapistas.size()


    method todosPuedenPagar(unPrecio) = escapistas.all {unEscapista => unEscapista.puedePagar(unPrecio)}

    method sumaDeSaldosCubre(unPrecio) = escapistas.sum {unEscapista => unEscapista.dinero()} >= unPrecio

    method pagar(unaSala) {
        escapistas.forEach {unEscapista => unEscapista.pagar(self.precioSalaPorGrupo(unaSala))}
    }


}

object amateur {

    method puedeSalir(unaSala, unEscapista) = ! unaSala.dificil() and unEscapista.hizoMuchasSalas()

    method evolucionar() = profesional
}

object profesional {

    method puedeSalir(_unaSala, _unEscapista) = true

    method evolucionar() = self
}