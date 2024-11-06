import armas.*

class Familia {
    const integrantes = []

    // B)
    method elMasPeligroso() = self.integrantesVivos().max {unIntegrante => unIntegrante.cantidadArmas()}

    method integrantesVivos() = integrantes.filter {unIntegrante => ! unIntegrante.estaDurmiendoConLosPeces()} 

    // C)
    method armarALaFamilia() {
        integrantes.forEach {unIntegrante => unIntegrante.agregarArma(new Revolver(cantidadBalas = 6))}
    }
    // E)
    method atacarPorSorpesa(unaFamilia) {
        integrantes.forEach {unIntegrante => unIntegrante.atacarFamilia(unaFamilia)}
    }
    // F)

    method reorganizarse() {
        self.nombrarSubJefes()
        self.nombrarDon()
        self.aumentarLealtadATodos()
    }

    method nombrarSubJefes() {
        const miembrosArmados = integrantes.filter{unIntegrante => unIntegrante.cantidadArmas() > 5}
        miembrosArmados.forEach {unMiembro => unMiembro.ascenderASubJefe()}
    }

    method nombrarDon() {
        integrantes.max {unIntegrante => unIntegrante.lealtad()}.ascenderADon()
    }

    method aumentarLealtadATodos() {
        integrantes.forEach {unIntegrante => unIntegrante.aumentarLealtadPorLuto()}
    }

    method lealtadEnPromedio() = integrantes.sum {unIntegrante => unIntegrante.lealtad()} / integrantes.size()

    method ataquePorTraidor(unTraidor) {
        integrantes.forEach {unIntegrante => unTraidor.realizarTrabajo(unTraidor, unIntegrante)}
    }

    method incoporarTraidor(unTraidor) {
        integrantes.add(unTraidor)
    }
}