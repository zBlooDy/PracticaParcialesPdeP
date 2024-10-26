class ArbolNavidad {

  const regalos = []
  const tarjetas = []
  const adornos = []
  
  method capacidadRegalos()

  method agregarRegalo(unRegalo) {
    self.verificarEspacio()

    regalos.add(unRegalo)
  }

  method verificarEspacio() {
    if(!regalos.size() <= self.capacidadRegalos()) {
      throw new DomainException(message = "No hay espacio para regalos")
    }
  }

  method beneficiarios() {
    const personasConRegalo = self.beneficiariosRegalos()
    const personasConTarjeta = self.beneficiariosTarjetas()
    return personasConRegalo + personasConTarjeta
  }

  method beneficiariosRegalos() = regalos.map {unRegalo => unRegalo.destinatario()}

  method beneficiariosTarjetas() = tarjetas.map {unaTarjeta => unaTarjeta.destinatario()}

  method costoTotalEnRegalos() = regalos.sum {unRegalo => unRegalo.precio()}

  method importanciaDelArbol() = adornos.sum {unAdorno => unAdorno.importancia()}

  method regaloMuyQueridoDelArbol(unRegalo) = unRegalo.precio() > self.promedioRegalos()

  method promedioRegalos() = self.costoTotalEnRegalos() / regalos.size()

  method potentoso() = self.variosRegalosMuyQueridos() or self.hayTarjetaCara()

  method variosRegalosMuyQueridos() {
    const regalosMuyQueridos = regalos.filter {unRegalo => self.regaloMuyQueridoDelArbol(unRegalo)}
    
    return regalosMuyQueridos.size() > 5
  }

  method hayTarjetaCara() = tarjetas.any {unaTarjeta => unaTarjeta.valorAdjunto() > 1000}

  method adornoMasPesado() = adornos.max {unAdorno => unAdorno.peso()}

}

class ArbolNatural inherits ArbolNavidad {

  const vejez
  const tamanioTronco

  override method capacidadRegalos() = vejez * tamanioTronco
}

class ArbolArtificial inherits ArbolNavidad {
  const cantidadVaras

  override method capacidadRegalos() = cantidadVaras
}