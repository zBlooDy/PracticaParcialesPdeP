class Tematica {

    const titulo

    method titulo() = titulo
    
    method cantidadPalabrasTitulo() = titulo.words().size()

    method esInteresante() = false

    method afectarA(unPanelista) = unPanelista.incrementarPuntos(1)

}

class Deportiva inherits Tematica {

    override method afectarA(unPanelista) = unPanelista.puntosPorDeporte(1,5)

    override method esInteresante() = titulo.contains("Messi")
}

class Farandula inherits Tematica {
    const involucrados = []

    override method afectarA(unPanelista) = unPanelista.puntosPorFarandula(1, self.cantidadInvolucrados())

    method cantidadInvolucrados() = involucrados.size()

    override method esInteresante() = self.cantidadInvolucrados() > 3
}


class Filosofica inherits Tematica {

    override method esInteresante() = self.cantidadPalabrasTitulo() > 20
}

class Mixta {

    const tematicas = []

    method titulo() = self.titulosTematicas().join("")

    method titulosTematicas() = tematicas.map {unaTematica => unaTematica.nombre()}

    method esInteresante() = tematicas.any {unaTematica => unaTematica.esInteresante()}


    method afectarA(unPanelista) = tematicas.forEach {unaTematica => unaTematica.afectarA(unPanelista)}
}



