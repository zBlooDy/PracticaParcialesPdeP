class Mision {

    const tipoMision

    method puedeCompletarla(unBarco) = unBarco.tieneSuficienteTripulacion() && tipoMision.puedeRealizarla(unBarco)

    method esUtil(unPirata) = tipoMision.esUtil(unPirata)
}

class BusquedaDelTesoro {

    method esUtil(unPirata) = self.tieneCiertosItems(unPirata) && unPirata.tieneMenosMonedasQue(5)

    method tieneCiertosItems(unPirata) = unPirata.tiene("Brujula") || unPirata.tiene("Mapa") || unPirata.tiene("Botella de grogXD")


    method puedeRealizarla(unBarco) = unBarco.alguienTiene("Llave de cofre")
}

class ConvertiseEnLeyenda {
    const itemRequerido
    
    method esUtil(unPirata) = unPirata.tieneSuficientesItems(10) && unPirata.tiene(itemRequerido)

    method puedeRealizarla(unBarco) = true
}

class Saqueo {
    const victima

    method esUtil(unPirata) = unPirata.tieneMenosMonedasQue(monedas.cantidad()) && unPirata.puedeAtacar(victima)

    method puedeRealizarla(unBarco) = victima.esVulnerableA(unBarco)
}

object monedas {
    var property cantidad = 8
}


class Victima {
    const nivelEbriedad
    const personas = []
    const porcentaje

    method puedeSerSaqueadaPor(unPirata) = unPirata.nivelDeEbriedadMayorA(nivelEbriedad)

    method esVulnerableA(unBarco) = self.cantidadPersonas() < unBarco.cantidadPersonas() * porcentaje

    method cantidadPersonas() = personas.size()
}

