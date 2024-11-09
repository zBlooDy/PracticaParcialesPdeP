import lenguajes.*

class Empleado {

  const lenguajes = []

  method estaInvitado()

  method aprender(unLenguaje) {
    lenguajes.add(unLenguaje)
  }

  method sabeLenguajeViejo() = lenguajes.any {unLenguaje => unLenguaje.esViejo()}

  method esCopado() = false

  method sabeLenguajeModerno() = lenguajes.any {unLenguaje => unLenguaje.esModerno()}

  method mesa() = self.cantidadLenguajesModernos()

  method cantidadLenguajesModernos() = lenguajes.filter {unLenguaje => unLenguaje.esModerno()}.size()

  method regalo() = 1000 * self.cantidadLenguajesModernos()
}

class Jefe inherits Empleado {
  const empleados = []

  method tomarACargo(unEmpleado) {
    empleados.add(unEmpleado)
  }

  override method estaInvitado() = self.sabeLenguajeViejo() && self.tieneGenteCopada()

  method tieneGenteCopada() = empleados.all {unEmpleado => unEmpleado.esCopado()}

  override method mesa() = 99

  override method regalo() = super() + 1000 * empleados.size()
}

class Desarrollador inherits Empleado {

  override method estaInvitado() = lenguajes.contains(wollokDodain) || self.sabeLenguajeViejo()

  override method esCopado() = self.sabeLenguajeViejo() && self.sabeLenguajeModerno()
}

class Infraestructura inherits Empleado {

  const experiencia

  override method esCopado() = self.tieneMuchaExperiencia()

  override method estaInvitado() = lenguajes.size() >= 5


  method tieneMuchaExperiencia() = experiencia > 10
}