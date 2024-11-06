class Discusion {
    const partidoA
    const partidoB
    
    method esBuena() = partidoA.aptoParaDiscutir() && partidoB.aptoParaDiscutir() 
}

class Partido {
    const filosofo
    const argumentos

    method aptoParaDiscutir() = self.mitadArgumentosEnriquecedores() && filosofo.estaEnLoCorrecto()

    method mitadArgumentosEnriquecedores() {
        const cantidadArgumentos = argumentos.size()
        const cantidadArgumentosEnriquecedores =  argumentos.filter{unArgumento => unArgumento.enriquecedor()}.size()
        return cantidadArgumentosEnriquecedores >= cantidadArgumentos/2
    }
}

class Argumento {
    const descripcion
    const naturaleza

    method enriquecedor() = naturaleza.enriqueceSegun(descripcion)
}

object estoica  {
    method enriqueceSegun(_unaDescripcion) = true
}

object moralista {
    method enriqueceSegun(unaDescripcion) = unaDescripcion.size() > 10
}

object esceptica {
    method enriqueceSegun(unaDescripcion) = unaDescripcion.last() == "?"
}

object cinica {
    method enriqueceSegun(_unaDescripcion) = 1.randomUpTo(100) <= 30
}

class Combinada {
    const naturalezas

    method enriqueceSegun(unaDescripcion) = self.sonTodasEnriquecedoras(unaDescripcion)

    method sonTodasEnriquecedoras(unaDescripcion) = naturalezas.all {unaNaturaleza => unaNaturaleza.enriqueceSegun(unaDescripcion)}
}