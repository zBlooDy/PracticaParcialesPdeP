class Jugador {
    var nivelSospecha
    var puedeVotar = true
    var estaVivo

    const mochila = []

    method nivelSospecha()

    method esSospechoso() = nivelSospecha > 50

    method buscar(unItem) {
        mochila.add(unItem)
    }

    method removerItem(unItem) {
        mochila.remove(unItem)
    }

    method aumentarSospecha(unaCantidad) {
        nivelSospecha += unaCantidad
    }

    method disminuirSospecha(unaCantidad) {
        nivelSospecha -= unaCantidad
    }

    method cancelarVoto() {
        puedeVotar = false
    }

    method llamarReunionEmergencia() {
        nave.votacionParaExpulsar()
    }

    method votarA(unosJugadores) {
        if(puedeVotar) {
            return self.votar(unosJugadores)
        } else {
            self.votarEnBlanco()
        }
    }

    method votarEnBlanco() {
        return votoEnBlanco
        puedeVotar = true
    }

    method estaVivo() = estaVivo

    method votar(unosJugadores)

    method tieneItems() = mochila.isEmpty()

    method expulsar() {
        estaVivo = false
    }
}

class Tripulante inherits Jugador {

    const personalidad
    
    const tareas = []

    method completoSusTareas() = tareas.isEmpty()

    method realizarTarea() {
        self.realizarTareaPendiente()
        self.avisarNave()
    }

    method realizarTareaPendiente() {
        const tarea = tareas.find {unaTarea => unaTarea.puedeRealizarla(self)}
        tarea.realizatePor(self)
        tareas.remove(tarea)
    }

    method avisarNave() {
        nave.seTerminoUnaTarea()
    }

    method usarItems(unosItems) {
        unosItems.forEach {unItem => self.removerItem(unItem)}
    }

    override method votar(unosJugadores) = personalidad.votarEnBaseA(unosJugadores)

    override method expulsar() {
        super()
        nave.disminuirTripulante()
    }

    


}

class Impostor inherits Jugador {


    method completoSusTareas() = true

    method realizarTarea() {
        // No hace nada 
    }

    method realizarSabotaje(unSabotaje) {
        unSabotaje.sabotear()
        self.aumentarSospecha(5)
    }

    method votarEnBaseA(unosJugadores) = unosJugadores.anyOne()


    override method expulsar() {
        super()
        nave.disminuirImpostor()
    }
}

object nave {
    
    var nivelOxigeno = 1

    var cantidadTripulantes = 6
    var cantidadImpostores = 2
    
    const jugadores = []
    
    method aumentarOxigeno(unaCantidad) {
        nivelOxigeno += unaCantidad
    }

    method seTerminoUnaTarea() {
        if(self.terminaronTodasLasTareas()) {
            throw new DomainException(message = "Ganaron los tripulantes")
        }
    }

    method terminaronTodasLasTareas() = jugadores.all {unJugador => unJugador.completoSusTareas()}

    method sabotearOxigeno(unaCantidad) {
        nivelOxigeno =- unaCantidad
        self.verificarOxigeno()
    }

    method verificarOxigeno() {
        if(nivelOxigeno == 0) {
            throw new DomainException(message = "Ganaron los impostores")
        }
    }


    method votacionParaExpulsar() {
        const votos = jugadores.map {unJugador => unJugador.votar(self.jugadoresVivos())}
        const jugadorMasVotado = votos.max {unVoto => votos.occurrencesOf(votos)}
        jugadorMasVotado.expulsar()
        self.verificarGanador()
    }

    method jugadoresVivos() = jugadores.filter {unJugador => unJugador.estaVivo()}

    method disminuirTripulante() {
        cantidadTripulantes = -1
    }

    method disminuirImpostor() {
        cantidadImpostores =- 1
    }

    method verificarGanador() {
        self.verificarGanaronTripulantes()
        self.verificarGanaronImpostores()
    }

    method verificarGanaronTripulantes() {
        if(cantidadImpostores == 0) {
            throw new DomainException(message = "Ganaron los tripulantes")
        }
    }

    method verificarGanaronImpostores() {
        if(cantidadImpostores > cantidadTripulantes) {
            throw new DomainException(message = "Ganaron los impostores")
        }
    }


}

object votoEnBlanco {

    method expulsar() {}
}