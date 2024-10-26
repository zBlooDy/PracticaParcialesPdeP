class Adorno {
    
    const peso
    const pesoBase
    const coeficienteSuperioridad

    method peso() = peso
    
    method importancia() = peso * coeficienteSuperioridad

}

class Luz inherits Adorno {
    const cantidadLamparitas

    override method importancia() = super() * cantidadLamparitas
}

class Figura inherits Adorno {
    const volumen

    override method importancia() = super() + volumen
}

class Guirnalda inherits Adorno {
    const aniosUsada
    
    override method peso() = pesoBase - 100 * aniosUsada
}