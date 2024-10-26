object premium {

  const costo = 50

  method costo() {
    return costo
  }

  method puedeJugar(_unJuego) {
    return true
  }

}

object base {
  
  const costo = 25

  method costo() {
    return costo
  }

  method puedeJugar(unJuego) {
    return unJuego.precio() < 30
  }
}

object infantil {

  const costo = 10
  
  method costo() {
    return costo
  }

  method puedeJugar(unJuego) {
    return unJuego.categoria() == "infantil"
  }
}

object prueba {

  const costo = 0
  
  method costo() {
    return costo
  }

  method puedeJugar(unJuego) {
    return unJuego.categoria() == "demo"
  }
}