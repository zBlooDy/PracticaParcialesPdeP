class Filosofo {
  const nombre
  const honorificos = #{}
  const actividades = []
  var nivelIluminacion
  var edad
  var diasVividos

  method presentarse() = honorificos.join(",") + nombre

  method estaEnLoCorrecto() = nivelIluminacion > 1000

  method nivelIluminacion() = nivelIluminacion

  method aumentarIluminacion(unaCantidad) {
    nivelIluminacion += unaCantidad
  }
  
  method disminuirIluminacion(unaCantidad) {
    nivelIluminacion -= unaCantidad
  }

  method agregarHonorifico(unHonorifico) {
    honorificos.add(unHonorifico)
  }

  method rejuvenecer(unosDias) {
    edad =- unosDias
  }

  method vivirUnDia() {
    self.realizarActividades()
    self.pasarTiempo()
    
  }

  method realizarActividades() {
    actividades.forEach {unaActividad => unaActividad.afectarA(self)}
  }

  method pasarTiempo() {
    diasVividos += 1
    self.verificarCumpleanios()
  }

  method verificarCumpleanios() {
    if(diasVividos == 365) {
      self.cumplirAnios()
    }
  }

  method cumplirAnios() {
    edad += 1
    diasVividos = 0
    self.aumentarIluminacion(10)
    self.verificarSabio()
  }

  method verificarSabio() {
    if(edad == 60){
      self.agregarHonorifico("el sabio")
    }
  }
}

class FilosofoContemporaneo inherits Filosofo {
  const esAmanteDeLaBotanica
  
  override method presentarse() = "hola"

  override method nivelIluminacion() = self.verificarBotanica()

  method verificarBotanica() {
    if(esAmanteDeLaBotanica) {
      return nivelIluminacion * 5
    } else {
      return nivelIluminacion
    }
  }

}
