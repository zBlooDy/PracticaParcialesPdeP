class Victima {
    const nivelEbriedad
    const porcentaje

    method puedeSerSaqueadaPor(unPirata) = unPirata.nivelDeEbriedadMayorA(nivelEbriedad)

    method esVulnerableA(unBarco) 

}

class Barco inherits Victima(nivelEbriedad = 90, porcentaje = 0.5){
    var mision
    const capacidad
    var tripulantes = []

    method tieneSuficienteTripulacion() = self.cantidadTripulantes() >= 0.9 * capacidad

    method puedeRealizarMision() = mision.puedeCompletarla(self)

    method alguienTiene(unItem) = tripulantes.any {unTripulante => unTripulante.tiene(unItem)}

    method cambiarMision(nuevaMision) {
        mision = nuevaMision
        tripulantes = tripulantes.filter {unTripulante => unTripulante.esUtilPara(nuevaMision)}
    }

    override method esVulnerableA(unBarco) = self.cantidadTripulantes() < unBarco.cantidadPersonas() * porcentaje

    method cantidadTripulantes() = tripulantes.size()

    method estanTodosBorrachos() = tripulantes.all {unTripulante => unTripulante.estaPasadoDeGrog()}

    // 2)

    method puedeFormarParte(unPirata) = self.hayLugar() && unPirata.esUtilPara(mision)

    method hayLugar() = self.cantidadTripulantes() < capacidad

    method incorporarPirata(unPirata) {
        if(self.puedeFormarParte(unPirata)) {
            tripulantes.add(unPirata)
        }
    }
    
    // 3)

    method elMasEbrio() = tripulantes.max {unTripulante => unTripulante.ebriedad()}

    method anclarEn(unaCiudad) {
        tripulantes.forEach {unTripulante => unTripulante.tomarTragoDeGrog()}
        tripulantes.remove(self.elMasEbrio())
        unaCiudad.agregarHabitante(self.elMasEbrio())
    }

    // 4)

    method esTemible() = self.puedeRealizarMision()

    // 5)

    method tripulantesPasadosDeGrog() = tripulantes.filter {unTripulante => unTripulante.estaPasadoDeGrog()}
    
    method cuantosTripulantesPasadosDeGrog() = self.tripulantesPasadosDeGrog().size()

    method itemsDePasadosDeGrog() = self.tripulantesPasadosDeGrog().flatMap {unTripulante => unTripulante.items()}.asSet()

    method elBorrachoMasAdinerado() = self.tripulantesPasadosDeGrog().max {unBorracho => unBorracho.monedas()}

    // 6)

    method elQueMasInvito() {
        const invitados = tripulantes.map {unTripulante => unTripulante.quienInvito()}
        return invitados.max {unTripulante => invitados.occurrencesOf(unTripulante)}
    }
}   

class CiudadCostera inherits Victima(nivelEbriedad = 50, porcentaje = 0.4) {

    const personas = []

    override method esVulnerableA(unBarco) = personas.size() < unBarco.cantidadPersonas() * porcentaje || unBarco.estanTodosBorrachos()

    method agregarHabitante(unHabitante) {
        personas.add(unHabitante)
    }

}