class Rol {

    method tieneHerramientas(unasHerramientas) = false

    method esMucama() = false

    method fuerzaRol() = 0

    method perderEstaminaPorDefender(unMinion) {
        unMinion.disminuirEstamina(unMinion.estamina() / 2)
    }

    method actualizar() {}

    method realizarTareaPor(unMinion, unaTarea) {
        unaTarea.realizatePor(unMinion)
    }
    
}


class Soldado inherits Rol {
    var practica

    // No explica muy bien como se aumenta la practica
    method usarArma() {
        practica += 1
    }

    override method fuerzaRol() = practica

    override method perderEstaminaPorDefender(unMinion) {}

    override method actualizar() {
        practica = 0
    }


}

class Obrero inherits Rol {
    const herramientas

    override method tieneHerramientas(unasHerramientas) = unasHerramientas.all {unaHerramienta => herramientas.contains(unaHerramienta)}
}

class Mucama inherits Rol {

    override method esMucama() = true
}

class Capataz inherits Rol {

    const subordinados = []

    override method realizarTareaPor(unMinion, unaTarea) {
        const subordinadosCapaces = subordinados.filter {unSubordinado => unaTarea.puedeRealizarla(unSubordinado)}
        if(! subordinadosCapaces.isEmpty()) {
            const elMasExperimentado = subordinadosCapaces.max {unSubordinado => unSubordinado.experiencia()}
            elMasExperimentado.realizar(unaTarea)
        } else {
            unMinion.realizar(unaTarea)
        }
    }
}


