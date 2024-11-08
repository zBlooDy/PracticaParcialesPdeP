class Tarea {

    method puedeRealizarla(unMinion) = self.tieneLasCapacidades(unMinion)

    method tieneLasCapacidades(unMinion)

    method realizatePor(unMinion) {
        self.verificarPuedeRealizarla(unMinion)

        self.afectarA(unMinion)
    }

    method verificarPuedeRealizarla(unMinion) {
        if(!self.puedeRealizarla(unMinion)) {
            throw new DomainException (message = "No puede realizar la tarea")
        }
    }

    method afectarA(unMinion)


}


class ArreglarMaquina inherits Tarea {
    const complejidadMaquina
    const herramientasNecesarias

    override method tieneLasCapacidades(unMinion) = unMinion.tieneSuficienteEstaminaQue(complejidadMaquina) && unMinion.tiene(herramientasNecesarias)

    override method afectarA(unMinion) {
        unMinion.perderEstamina(complejidadMaquina)
    }

    method dificultadSegun(_unMinion) = 2 * complejidadMaquina

}

class DefenderSector inherits Tarea {
    const gradoAmenaza

    override method tieneLasCapacidades(unMinion) = ! unMinion.tieneRolMucama() && unMinion.esMasFuerteQue(gradoAmenaza)

    override method afectarA(unMinion) {
        unMinion.defenderSector()
    }

    method dificultadSegun(unMinion) = unMinion.dificultadSector(gradoAmenaza)

}

class LimpiarSector inherits Tarea {
    const esGrande

    override method tieneLasCapacidades(unMinion) = unMinion.tieneMasEstimaQue(self.estaminaSegunSector()) || unMinion.tieneRolMucama()


    method estaminaSegunSector() {
        if(esGrande) {
            return 4
        } else {
            return 1
        }
    }

    override method afectarA(unMinion) {
        unMinion.limpiarSector(self.estaminaSegunSector())
    }

    method dificultadSegun(_unMinion) = tareaLimpieza.dificultad()
}

object tareaLimpieza {

    
    method dificultad() = 10
}