class Empleado {

  var estamina 
  var rol
  const tareasRealizadas = []

  method comer(unaFruta) {
    self.recuperarEstamina(unaFruta.puntos())
  }

  method estamina() = estamina

  method recuperarEstamina(unaCantidad) 


  method tieneSuficienteEstaminaQue(unaCantidad) = estamina >= unaCantidad

  method tiene(unasHerramientas) {
    rol.tieneHerramientas(unasHerramientas)
  }

  method tieneRolMucama() = rol.esMucama()

  method esMasFuerteQue(unaCantidad) = self.fuerza() >= unaCantidad

  method fuerza() = estamina/2 + 2 + rol.fuerzaRol()

  method defenderSector() {
    rol.perderEstaminaPorDefender(self)
  }

  method disminuirEstamina(unaCantidad) {
    estamina =- unaCantidad
  }

  method dificultadSector(unGradoAmenaza) = unGradoAmenaza

  method tieneMasEstaminaQue(unaCantidad) = estamina >= unaCantidad

  method limpiarSector(estaminaConsumida) {
    if(! self.tieneRolMucama()) {
      self.disminuirEstamina(estaminaConsumida)
    }
  }

  method cambiarRol(nuevoRol) {
    rol = nuevoRol
    nuevoRol.actualizar()
  }

  // 3)
  method realizar(unaTarea) {
    rol.realizarTareaPor(self, unaTarea)
    
    self.agregarTarea(unaTarea)
    
  }

  method agregarTarea(unaTarea) {
    tareasRealizadas.add(unaTarea)
  }

  // 2)
  method experiencia() = tareasRealizadas.sum {unaTarea => unaTarea.dificultadSegun(self)}



}

class Biclope inherits Empleado {
  
  override method recuperarEstamina(unaCantidad) {
    estamina = 10.min(estamina + unaCantidad) 
  }


}

class Ciclope inherits Empleado {

  override method recuperarEstamina(unaCantidad) {
    estamina += unaCantidad
  }

  override method fuerza() = super() / 2
  
  override method dificultadSector(unGradoAmenaza) = super(unGradoAmenaza) * 2
}


object banana {
  method puntos() = 10
}


object manzana {
  method puntos() = 5
}


object uva {
  method puntos() = 1
}