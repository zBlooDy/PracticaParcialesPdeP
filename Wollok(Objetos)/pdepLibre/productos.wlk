class Producto {
  const precioBase
  const nombre


  method precioConIva() {
    return precioBase * 1.21 
  }

  method precio() {
    return self.precioConIva() 
  }

  method nombreOferta() {
    return "SUPER OFERTA" + nombre
  }
}

/*Hago clases en vez de objetos porque cuando llegamos a Indumentaria, necesitas
definir una variable que sea esDeTemporada, y el objeto te la pide inicializada */

class Mueble inherits Producto {

  override method precio() {
    return super() + 1000
  }

}

class Indumentaria inherits Producto {
  
  const esDeTemporada

  method aumentoSegunTemporada() {
    if(esDeTemporada) {
      return 0.1
    } else {
      return 0
    }
  }

  override method precio() {
    return super() + super() * self.aumentoSegunTemporada()
  }

}

class Gangas inherits Producto {
  
  override method precio() {
    return 0
  }
  
  override method nombreOferta() {
    return super() + "COMPRAME POR FAVOR"
  }
}
