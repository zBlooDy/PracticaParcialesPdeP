import movimientos.*

class Pokemon {
  const vidaMaxima
  const movimientos = []
  var vida
  var condicion = libre

  method grositud() = vidaMaxima * self.sumaPoderesMovimientos()

  method sumaPoderesMovimientos() = movimientos.sum {unMovimiento => unMovimiento.poder()}

  method curarse(unaCantidad) {
    vida = vidaMaxima.max(vida + unaCantidad)
  }

  method perderVida(unaCantidad) {
    vida =- unaCantidad
  }

  method aplicar(unaCondicion) {
    condicion = unaCondicion
  }

  method usarMovimientoA(unPokemon) {
    const movimiento = self.movimientoConUsos()
    movimiento.usarMovimiento(self, unPokemon)
  }


  method movimientoConUsos() = movimientos.findOrElse (
    {unMovimiento => unMovimiento.tieneUsos()}, 
    {throw new DomainException (message = "No tiene movimientos con usos")}
  )

  method estaVivo() = vida > 0

  method sePuedeMover() = condicion.puedeMoverse() && self.estaVivo()

  method lucharCon(unPokemon) {
    if(self.sePuedeMover()) {
      self.usarMovimientoA(unPokemon)
      self.intentarNormalizarCondicion()
    } else {
      condicion.aplicarConsecuencias(self)
    }
  }

  method intentarNormalizarCondicion() {
    condicion.normalizarse(self)
  }
}


