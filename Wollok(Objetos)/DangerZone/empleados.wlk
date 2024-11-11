class Empleado {
  var vida
  
  const habilidades = []
  var tipo

  method estaIncapacitado() = vida < tipo.saludCritica()



  method puedeUsar(unaHabilidad) = ! self.estaIncapacitado() && self.tiene(unaHabilidad)

  method tiene(unaHabilidad) = habilidades.contains(unaHabilidad)

  method esCapazDeUsar(unasHabilidades) = unasHabilidades.all {unaHabilidad => self.puedeUsar(unaHabilidad)}
  

  method realizar(unaMision) {
    unaMision.afectarA(self)
    self.recompensaPorSobrevivir(unaMision)
  }

  method disminuirVida(unaCantidad) {
    vida =- unaCantidad
  }

  method recompensaPorSobrevivir(unaMision) {
    if(vida > 0) {
      tipo.registrarMisionPor(self, unaMision)
    }
  }

  method tipo(nuevoTipo) {
    tipo = nuevoTipo
  }

  method agregarHabilidad(unaHabilidad) {
    habilidades.add(unaHabilidad)
  }

}

object espia  {

  method saludCritica() = 15

  method registrarMision(unEmpleado, unaMision) {
    const habilidadesMision = unaMision.habilidadesRequeridas()
    const habilidadesSinSaber = habilidadesMision.filter {unaHabilidad => ! unEmpleado.tiene(unaHabilidad)}
    habilidadesSinSaber.forEach {unaHabilidad => unEmpleado.agregarHabilidad(unaHabilidad)}
  }
}

class Oficinista  {
  var estrellas

  method saludCritica() = 40 - 5 * estrellas

  method registrarMisionPor(unEmpleado, _unaMision) {
    if(estrellas == 3) {
      self.ascender(unEmpleado)
    } else {
      estrellas += 1
    }
  }

  method ascender(unEmpleado) {
    unEmpleado.tipo(espia)
  }
}

class Jefe inherits Empleado {
  const subordinados

  override method tiene(unaHabilidad) = subordinados.any {unSubordinado => unSubordinado.puedeUsar(unaHabilidad)}
}

class Equipo {
  const integrantes = []

  method algunoEsCapaz(unasHabilidades) = integrantes.any {unIntegrante => unIntegrante.puedeUsar(unasHabilidades)}

  method realizar(unaMision) {
    unaMision.afectarA(self)
  }


  method pierdenVida(unaCantidad) = integrantes.forEach {unIntegrante => unIntegrante.disminuirVida(unaCantidad)}
}