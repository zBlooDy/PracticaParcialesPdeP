class Pelicula {

  const nombre
  const elenco 
  const recaudacion = 1000000

  method sumaSueldosElencos() {
    return elenco.sum {artista => artista.sueldo()}
  }



  method presupuestoBase() {
    return self.sumaSueldosElencos() + (0.7 * self.sumaSueldosElencos())
  }

  method presupuesto() {
    return self.presupuestoBase() 
  }

  method recaudacion() {
    return recaudacion
  }

  method ganancia() {
    return self.recaudacion() - self.presupuesto()
  }

  method cantidadElenco() {
    return elenco.size()
  }
  
  method cantidadLetrasEnNombre() {
    return nombre.size()
  }

  method rodar() {
    elenco.forEach({artista => artista.actuar()})
  }

  method economica() {
    return self.presupuesto() < 500000
  }
  
}

class PeliculaAccion inherits Pelicula {

  const cantidadVidriosRotos

  override method presupuesto() {
    return self.presupuestoBase() + 1000 * cantidadVidriosRotos
  }

  override method recaudacion() {
    return recaudacion + 50000 * self.cantidadElenco()
  }
}

class PeliculaDrama inherits Pelicula {

  override method recaudacion() {
    return recaudacion + 100000 * self.cantidadLetrasEnNombre()
  }
}

class PeliculaTerror inherits Pelicula {

  const cantidadCuchillos

  override method recaudacion() {
    return recaudacion + 20000 * cantidadCuchillos
  }
}
