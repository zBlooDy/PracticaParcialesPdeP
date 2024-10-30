class Plato {
  const azucar

  const autor

  method calorias() = 3 * azucar + 100

  method azucar() = azucar

  method esBonito()

  method autor() = autor
}

class Entrada inherits Plato(azucar = 0) {

  override method esBonito() = true
}

class Principal inherits Plato {
  const bonito

  override method esBonito() = bonito
}

class Postre inherits Plato (azucar = 120) {
  const cantidadColores

  override method esBonito() = cantidadColores > 3
}

