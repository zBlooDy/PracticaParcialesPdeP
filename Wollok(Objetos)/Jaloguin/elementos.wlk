class Maquillaje {

    method nivelDeSusto() = 3
}

class Traje {
    const tipo

    method nivelDeSusto() = tipo.susto()
}

object tierno {
    const susto = 2

    method susto() = susto
}

object terrorifico {
    const susto = 5

    method susto() = susto
}