import jugadores.*

object reducirOxigeno {

    method sabotear() {
        nave.sabotearOxigeno(10)
    }
}

class ImpugnarJugador {
    const jugadorAImpugnar

    method sabotear() {
        jugadorAImpugnar.cancelarVoto()
    }
}

