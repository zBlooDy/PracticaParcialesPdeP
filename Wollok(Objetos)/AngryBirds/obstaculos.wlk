class Pared {
    const tipo
    const ancho

    method resistencia() = tipo.durabilidad() * ancho
}

class Tipo {
    const durabilidad

    method durabilidad() = durabilidad
}

const vidrio = new Tipo(durabilidad = 10)
const madera = new Tipo(durabilidad = 15)
const piedra = new Tipo(durabilidad = 20)


object cerditoObrero {
    const resistencia = 50

    method resistencia() = resistencia
}

class CerditoArmado {
    const armadura

    method resistencia() = 10 * armadura.resistenciaEquipamiento()
}

class Armadura {
    const resistenciaEquipamiento

    method resistenciaEquipamiento() = resistenciaEquipamiento
}
