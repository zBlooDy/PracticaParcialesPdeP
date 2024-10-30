class Pirata {

  var monedas
  const items = []
  var ebriedad
  const quienInvito

  method esUtilPara(unaMision) = unaMision.esUtil(self)

  method monedas() = monedas

  method tiene(unItem) = items.contains(unItem)

  method tieneSuficientesItems(cantidadItems) = items.size() > cantidadItems

  method puedeAtacar(unaVictima) = unaVictima.puedeSerSaqueadaPor(self)

  method estaPasadoDeGrog() = self.nivelDeEbriedadMayorA(90)

  method nivelDeEbriedadMayorA(unaCantidad) = ebriedad >= unaCantidad

  method ebriedad() = ebriedad

  method aumentarEbriedad(unaCantidad) {
    ebriedad += unaCantidad
  }

  method tomarTragoDeGrog() {
    self.aumentarEbriedad(5)
    self.gastarMonedas(1)
  }

  method gastarMonedas(unaCantidad) {
    monedas =- unaCantidad
  }

  method items() = items

  method quienInvito() = quienInvito
}


class EspiaDeLaCorona inherits Pirata {

  override method estaPasadoDeGrog() = false

  override method puedeAtacar(unaVictima) = super(unaVictima) and self.tiene("Permiso de la corona")
}
