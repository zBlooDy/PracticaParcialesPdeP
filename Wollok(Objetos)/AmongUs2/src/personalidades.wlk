import jugadores.*

object troll {

    method votarEnBaseA(unosJugadores) = unosJugadores.findOrDefault ({unJugador => ! unJugador.esSospechoso()}, votoEnBlanco)
}

object detective {

    method votarEnBaseA(unosJugadores) = unosJugadores.max ({unJugador => unJugador.nivelSospecha()}, votoEnBlanco)
}

object materialista {

    method votarEnBaseA(unosJugadores) = unosJugadores.findOrDefault ({unJugador => ! unJugador.tieneItems()}, votoEnBlanco)
} 