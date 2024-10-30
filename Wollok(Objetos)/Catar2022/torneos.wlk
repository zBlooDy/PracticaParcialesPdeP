class Torneo {
    const platosPresentados = []
    const catadores = []

    method agregarPlato(unPlato) {
        platosPresentados.add(unPlato)
    }

    method ganadorTorneo() {
        self.verificarHayPlatos()

        const mejorPlato = platosPresentados.max {unPlato => self.calificacionDeCatadores(unPlato)}

        return mejorPlato.autor()
    }

    method calificacionDeCatadores(unPlato) = catadores.sum {unCatador => unCatador.catar(unPlato)}

    method verificarHayPlatos() {
        if(platosPresentados.isEmpty()) {
            throw new DomainException(message = "No hay platos presentados, no hay ganador")
        }
    }


}
