class Traicion {
    const traidor
    const nuevaFamilia
    const victimas = []
    var fechaTentativa


    method complicarse(unosDias) {
        fechaTentativa =- unosDias
    }

    method ajusticiar() {
        if(self.tieneMenosLealtad()) {
            traidor.morir()
        }
        else {
            self.concretar()
        }
    }

    method tieneMenosLealtad() = 2 * traidor.lealtad() < victimas.anyOne().promedioLealtadFamilia()

    method concretar() {
        traidor.atacarFamilia()
        traidor.familia(nuevaFamilia)
        nuevaFamilia.incorporarTraidor(traidor)
    }
}