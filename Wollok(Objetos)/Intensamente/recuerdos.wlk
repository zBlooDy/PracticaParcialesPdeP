class Recuerdo {
  
  const descripcion
  const fecha
  const emocionDominanteActual

  method afectarA(unaPersona) {
    emocionDominanteActual.influirEn(unaPersona, self)
  }

  method esDificilDeExplicar() = descripcion.words().size() > 10

  method esAlegre() = emocionDominanteActual.alegre()
}

object alegre {

  method influirEn(unaPersona, unRecuerdo) {
    if(unaPersona.estaFeliz()) {
      unaPersona.agregarAPensamientosCentrales(unRecuerdo)
    }
  }

  method negar(unRecuerdo) = not unRecuerdo.esAlegre()
}

object triste {

  method influirEn(unaPersona, unRecuerdo) {
    unaPersona.agregarAPensamientosCentrales(unRecuerdo)
    unaPersona.disminuirFelicidad(0.1 * unaPersona.nivelFelicidad())
  }

  method negar(unRecuerdo) = unRecuerdo.esAlegre()
}

class Emocion {

    method influirEn(unaPersona, unRecuerdo) {}

    method alegre() = false

    method negar() = false
}
