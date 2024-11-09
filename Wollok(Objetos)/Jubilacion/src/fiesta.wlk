import juanPerez.*

class Fiesta {
    const costoFijo = 200000
    const asistentes = []
    
    method registrarAsistencia(unaPersona) {
        if(unaPersona.estaInvitado()) {
            self.agregarRegistro(unaPersona)
        }
    }

    method agregarRegistro(unaPersona) {
        asistentes.add(new Asistente(invitado = unaPersona, numeroDeMesa = unaPersona.mesa()))
    }

    method costoBase() = costoFijo + 5000 * asistentes.size()

    method balance() = self.importeRegalos() - self.costoBase()

    method importeRegalos() = asistentes.sum {unAsistente => unAsistente.regaloEnEfectivo() }

    method fueUnExito() = self.balance() > 0 && self.vinieronTodos()

    method vinieronTodos() = juanPerez.numeroInvitados() == asistentes.size()

    method mesaConMasAsistentes() {
        const mesas = asistentes.map {unAsistente => unAsistente.numeroDeMesa()}
        return mesas.max {unaMesa => mesas.occurrencesOf(unaMesa)}
    }

}

class Asistente {
    const invitado
    const numeroDeMesa


    method regaloEnEfectivo() = invitado.regalo()

    method numeroDeMesa() = numeroDeMesa
}