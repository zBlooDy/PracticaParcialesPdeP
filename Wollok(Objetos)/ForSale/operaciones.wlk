class Operacion {

  const tipoInmueble 
  
  const reserva

  method concretarOperacion(unaPersona, unEmpleado) {
    reserva.verificarReserva(unaPersona)
    unEmpleado.agregarOperacion(self)
  }

  method comision()

  method zona() = tipoInmueble.zona()

}

class Alquiler inherits Operacion {
  const cantidadMeses

  override method comision() = (cantidadMeses * tipoInmueble.valor()) / 50000 

}

class Venta inherits Operacion {
  const porcentaje = porcentajeAnual

  override method comision() = porcentaje.descuento() * tipoInmueble.valor()
}

object porcentajeAnual {
  
  method descuento() = 0.015
}

class Reserva {

  var estaReservada
  var futuroComprador

  method realizarReservaPor(unaPersona, unEmpleado) {
    if(!estaReservada) {
      self.reservar(unaPersona)
      unEmpleado.agregarReserva(self)
    }
  }

  method reservar(unaPersona) {
    estaReservada = true
    futuroComprador = unaPersona
  }

  method verificarReserva(unaPersona) {
    if(! unaPersona == futuroComprador) {
      throw new DomainException (message = "Personas distintas")
    }
  }

}