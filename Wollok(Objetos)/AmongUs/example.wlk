class Jugador {
    var nivelSospecha = 40
    var estaVivo = true
    const mochila = []
    var puedoVotar = true
    const personalidad

    method nivelSospecha() = nivelSospecha

    method esSospechoso() = nivelSospecha > 50

    method buscarItem(unItem) {
        mochila.add(unItem)
    }

    method aumentarSospecha(unaCantidad) {
        nivelSospecha += unaCantidad
    }

    method disminuirSospecha(unaCantidad) {
        nivelSospecha -= unaCantidad
    }

    method tiene(unItem) = mochila.contains(unItem)

    method usar(unItem) {
        mochila.remove(unItem)
    }

    method impugnarVoto() {
        puedoVotar = false
    }

    // Si bien el jugador inicia la reunion, la informacion minima lo tiene la nave
    method llamarReunionDeEmergencia() {
        nave.llamarReunionDeEmergencia()
    }



    method tieneItems() = ! mochila.isEmpty()

    method estaVivo() = estaVivo
}

class Tripulante inherits Jugador {
    const tareas = []

    method completoSusTareas() = tareas.isEmpty()

    method realizarTarea() {
        const tarea = self.tareaPendientePosible()
        tarea.realizatePor(self)
        tareas.remove(tarea)
        nave.terminarTarea()
    }

    method tareaPendientePosible() = tareas.find {unaTarea => unaTarea.puedeRealizarla(self)}

    method voto() = if(puedoVotar) {
        personalidad.voto()
    } else {
        self.votarEnBlanco()
    }

    method votarEnBlanco() {
        puedoVotar = true
        return votoEnBlanco          // El caso en el que un metodo hace y devuelve algo
    }

    method expulsar() {
        estaVivo = false
        nave.expulsarTripulante()
    }

}

class Impostor inherits Jugador {

    method completoSusTareas() = true

    method realizarTarea() {
        // No hace nada el gil 
    }

    method realizarSabotaje(unSabotaje) {
        self.aumentarSospecha(5)
        unSabotaje.realizate()
    }

    method voto() = nave.cualquierJugadorVivo()

    method expulsar() {
        estaVivo = false
        nave.expulsarImpostor()
    }
}

/* 
1. Si en vez de remover la tarea, cuando la completo, usaria un booleano tendria que utilizar instancias de clases, y hacer tantas tareas como jugadores las tenga
2. Igualmente es lo mismo usar Class o Object para estas tareas, vamos por clases y objetos (para mezclar) para darle a cada tripulante la tarea, y no sea "la misma" para todos
3. Al modificar el "Well Known Object" se modifica para todos, ya que este es conocido 
4. Como todas las tareas para realizarse la logica es necesitar items, lo unico q cambia es como afecta*/
class Tarea {
    const itemsNecesarios

    method puedeRealizarla(unJugador) = 
        itemsNecesarios.all {unItem => unJugador.tiene(unItem)}

    method realizatePor(unJugador) {
        self.usarItemsNecesarios(unJugador)
        self.afectarA(unJugador)
        unJugador.seCompleto(self)
    }

    method usarItemsNecesarios(unJugador) {
        itemsNecesarios.forEach({unItem => unJugador.usar(unItem)})
    }

    method afectarA(unJugador)
}

class ArreglarTablero inherits Tarea(itemsNecesarios = ["llave inglesa"]) {

    override method afectarA(unJugador) {
        unJugador.aumentarSospecha(10)
    }   
}

object sacarBasura inherits Tarea(itemsNecesarios = ["escoba", "bolsa consorcio"]){

    override method afectarA(unJugador) {
        unJugador.disminuirSospecha(4)
    }   
}

object ventilarNave inherits Tarea(itemsNecesarios = []){  

    override method afectarA(unJugador) {
        nave.aumentarOxigeno(5)
    }   
}

object nave {
    var nivelOxigeno = 100 // Para que no tire error
    var cantidadTripulantes = 7
    var cantidadImpostores = 2

    const jugadores = []

    method aumentarOxigeno(unaCantidad) {
        nivelOxigeno += unaCantidad
    }

    method terminarTarea() {
        if(self.seCompletaronTodasLasTareas()) {
            throw new DomainException (message = "Ganaron los tripulantes")
        }
    }
        
    method seCompletaronTodasLasTareas() = jugadores.all {unJugador => unJugador.completoSusTareas()}
    
    method sabotearOxigeno(unaCantidad) {
        if(not self.alguienTieneTuboDeOxigeno()) {
            self.reducirOxigeno(unaCantidad)
        }
    }

    method alguienTieneTuboDeOxigeno() = jugadores.any{unJugador => unJugador.tiene("tubo de oxigeno")}

    method reducirOxigeno(unaCantidad) {
        nivelOxigeno -= unaCantidad
        self.validarGanaronImpostores()
    }

    method validarGanaronImpostores() {
        if(nivelOxigeno < 0 or cantidadImpostores == cantidadTripulantes) {
            throw new DomainException(message = "Ganaron los impostores")
        }
    }

    method llamarReunionDeEmergencia() {
        const losVotitos = self.jugadoresVivos().map {unJugador => unJugador.voto()}
        const elMasVotado = losVotitos.max {unJugador => losVotitos.occurrencesOf(unJugador)}
        if(elMasVotado != votoEnBlanco) {
            elMasVotado.expulsar()
        }
    }

    method jugadoresVivos() = jugadores.filter {unJugador => unJugador.estaVivo()}

    method jugadorNoSospechoso() = self.jugadoresVivos().findOrDefault({unJugador => ! unJugador.esSospechoso()}, votoEnBlanco)

    method jugadorSinItems() = self.jugadoresVivos().findOrDefault({unJugador => unJugador.tieneItems()}, votoEnBlanco)

    method jugadorMasSospechoso() = self.jugadoresVivos().max {unJugador => unJugador.nivelSospecha()}

    method cualquierJugadorVivo() = self.jugadoresVivos().anyOne()

    method expulsarTripulante() {
        cantidadTripulantes -= 1
        self.validarGanaronImpostores()
    }

    method expulsarImpostor() {
        cantidadImpostores -=1
    }
}

object reducirOxigeno {
    
    method realizate() {
        nave.sabotearOxigeno(10)
    }
}


// Impugnar Jugador necesita conocer al jugador impugnado, entonces x cada sabotaje creo una instancia

class ImpugnarJugador {
    const jugadorImpugnado

    method realizate() {
        jugadorImpugnado.impugnarVoto()
    }
}

object troll {
    method voto() = nave.jugadorNoSospechoso()
}

object materialista {
    method voto() = nave.jugadorSinItems()
}

object detective {
    method voto() = nave.jugadorMasSospechoso()
}


object votoEnBlanco {

    method expulsar() {}
}