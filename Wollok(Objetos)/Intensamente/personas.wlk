import recuerdos.*

class Persona {
  var nivelFelicidad = 1000
  var emocionDominante
  const recuerdosDelDia = []
  const pensamientosCentrales = #{}
  const procesosMentales = []
  
  //1)
  method vivirUnEvento(unaDescripcion) {
    const recuerdoAsociado = new Recuerdo(descripcion = unaDescripcion, fecha = new Date(), emocionDominanteActual = emocionDominante)
    recuerdosDelDia.add(recuerdoAsociado)
  }  

  //2)
  method asentar(unRecuerdo) {
    unRecuerdo.afectarA(self)
  }

  method estaFeliz() = nivelFelicidad >= 500

  method agregarAPensamientosCentrales(unRecuerdo) {
    pensamientosCentrales.add(unRecuerdo)
  }
  
  method nivelFelicidad() = nivelFelicidad

  method disminuirFelicidad(unaCantidad) {
    nivelFelicidad -= unaCantidad
    self.verificarFelicidad()
  }

  method verificarFelicidad() {
    if(nivelFelicidad < 1) {
      throw new DomainException(message = "Nivel de felicidad muy bajo")
    }
  }

  //3)

  method recuerdosRecientes() = recuerdosDelDia.reverse().take(5)

  //4)

  method pensamientosCentrales() = pensamientosCentrales

  //5)

  method pensamientosCentralesDificiles() = pensamientosCentrales.filter {unRecuerdo => unRecuerdo.esDificilDeExplicar()}

  //6)
  method negarRecuerdo(unRecuerdo) = emocionDominante.negar(unRecuerdo)

  //7)
  method irADormir() {
    procesosMentales.forEach {unProcesoMental => unProcesoMental.afectar(self)}
  }

  method asentarTodosLosRecuerdos() {
    recuerdosDelDia.forEach {unRecuerdo => unRecuerdo.afectarA(self)}
  }

  
}

