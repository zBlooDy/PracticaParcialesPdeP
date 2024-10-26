object sesionManejoIra {

    const nivelRelajacion = 5

    method afectaA(unPajaro) {
        unPajaro.tranquilizarse(nivelRelajacion)
    }
}

class InvasionCerditos {
    
    const cantidadCerditos

    method cantidadVeces() = cantidadCerditos / 100

    method afectaA(unPajaro) {
        self.cantidadVeces().times {_ => unPajaro.enojarse()}
    }
}

class FiestaSorpresa {

    const pajarosAHomenajear

    method pajarosHomenajeados(unosPajaros) = unosPajaros.filter {unPajaro => pajarosAHomenajear.contains(unPajaro)}

    method afectaA(unPajaro) {
        self.verificarEstaPajaro(unPajaro)

        unPajaro.enojarse()
    }

    method verificarEstaPajaro(unPajaro) {
        if(!pajarosAHomenajear.isEmpty()) {
            throw new DomainException(message = "No hay fiesta sorpresa si no hay pajaros a homenajear")
        } else if (!pajarosAHomenajear.contains(unPajaro)) {}
    }
}

class EventosSorpresa {

    const eventosQueAfectan

    method afectaA(unPajaro) {
        eventosQueAfectan.forEach {unEvento => unEvento.afectaA(unPajaro)}
    }
}