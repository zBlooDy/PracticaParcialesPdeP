import armas.*

class IntegranteMafia {
    const armas = [new Escopeta()]
    var rol
    var vida
    var estaHerida = false
    var lealtad
    var familia

    method hacerTrabajoA(unaVictima) {
        rol.realizarTrabajo(self, unaVictima)
    }

    method armaAleatoria() = armas.anyOne()

    method armaAMano() = armas.first()

    method morir() {
        vida = 0
    }

    method herir() {
        if(estaHerida) {
            self.morir()
        } else {
            estaHerida = true
        }
    }

    method estaDurmiendoConLosPeces() = vida == 0

    method cantidadArmas() = armas.size()

    method agregarArma(unArma) {
        armas.add(unArma)
    }

    method sabeDespacharElegantemente() = rol.sabeDespachar(self)

    method tieneArmaSutil() = armas.anyOne().esSutil()

    method atacarFamilia(unaFamilia) {
        const atacado = unaFamilia.elMasPeligroso()
        if(! atacado.estaDurmiendoConLosPeces() ){
            self.hacerTrabajoA(atacado)
        }
    }

    method ascenderASubJefe() {
        rol = new SubJefe(subordinados = [])
    }

    method ascenderADon() {
        rol = new Don(subordinados = rol.subordinados())
    }

    method aumentarLealtadPorLuto() {
        lealtad =+ lealtad * 0.1
    }

    method promedioLealtadFamilia() = familia.lealtadEnPromedio()

    method familia(nuevaFamilia) {
        familia = nuevaFamilia
    }

    method atacarFamilia() {
        familia.ataquePorTraidor(self)
    }
}



class Don {
    const subordinados = []

    method realizarTrabajo(_unAtacante, unaVictima) {
        subordinados.anyOne().realizarTrabajo(_unAtacante, unaVictima)
    }

    method sabeDespachar(_unAtacante) = true
}

object donVito inherits Don {

    override method realizarTrabajo(_unAtacante, unaVictima) {
        const unSubordinado = subordinados.anyOne()
        unSubordinado.realizarTrabajo(_unAtacante, unaVictima)
        unSubordinado.realizarTrabajo(_unAtacante, unaVictima)
    }
}

class SubJefe {

    const subordinados 

    method realizarTrabajo(unAtacante, unaVictima) {
        unAtacante.armaAleatoria().hacerDanio(unaVictima)
    }

    method sabeDespachar(_unAtacante) = subordinados.anyOne().tieneArmaSutil()

    method subordinados() = subordinados
}

class Soldado {


    method realizarTrabajo(unAtacante, unaVictima) {
        unAtacante.armaAMano().hacerDanio(unaVictima)
    }

    method sabeDespachar(unAtacante) = unAtacante.tieneArmaSutil() 

}