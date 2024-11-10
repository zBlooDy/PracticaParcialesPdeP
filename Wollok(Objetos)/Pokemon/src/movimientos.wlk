class Movimiento {
  var usos

  method usarMovimiento(unPokemon, otroPokemon) {
    if(self.tieneUsos()) {
      usos =- 1
      self.afectarA(unPokemon, otroPokemon)
    }
  }

  method afectarA(unPokemon, otroPokemon)

  method tieneUsos() = usos > 0


}

class Curativo inherits Movimiento {
  const puntosSalud

  override method afectarA(unPokemon, _otroPokemon) {
    unPokemon.curarse(puntosSalud)
  }

  method poder() = puntosSalud
}

class Danino inherits Movimiento {
  const danio

  override method afectarA(_unPokemon, otroPokemon) {
    otroPokemon.perderVida(danio)
  }

  method poder() = danio * 2
}

class Especial inherits Movimiento {

  const condicion

  override method afectarA(_unPokemon, otroPokemon) {
    otroPokemon.aplicar(condicion)
  }

  method poder() = condicion.poderEspecial()
}

class CondicionEspecial {

  method puedeMoverse() = 0.randomUpTo(2).roundUp().even()

  method aplicarConsecuencias(unPokemon) {}
}

class Suenio inherits CondicionEspecial{

  method poderEspecial() = 50


  method normalizarse(unPokemon) = unPokemon.aplicar(libre)
}

class Paralisis {
  var puedeNormalizarse = false
  
  method poderEspecial() = 30


  method normalizarse(unPokemon) {
    if(puedeNormalizarse) {
      unPokemon.aplicar(libre)
    } else {
      puedeNormalizarse = true
    }
  }
}

class Confusion inherits CondicionEspecial {
  var turnosAfectados

  method poderEspecial() = 40 * turnosAfectados

  override method puedeMoverse() = turnosAfectados == 0

  method normalizarse(unPokemon) {
    if(turnosAfectados == 0) {
      unPokemon.aplicar(libre)
    } else {
      turnosAfectados = 0.max(turnosAfectados - 1)
    }
  }

  override method aplicarConsecuencias(unPokemon) {
    unPokemon.perderVida(20)
  }

}

object libre {

  method puedeMoverse() = true

  method normalizarse(_unPokemon) {}
}
