class Emision {

    const tematicas = []
    const panelistas = []
    var emisionCompleta = false


    method sePuedeEmitir() = self.haySuficientesPanelistas() && self.mitadTematicasInteresantes()

    method haySuficientesPanelistas() = panelistas.size() > 2

    method mitadTematicasInteresantes() {
        const tematicasInteresantes = tematicas.filter {unaTematica => unaTematica.esInteresante()}
        return tematicasInteresantes.size() > 2 * self.cantidadTematicas() 
    }

    method cantidadTematicas() = tematicas.size()

/*Interpretacion del enunciado: El programa cuando va a emitir hace que los panelistas
opinen y rematen sobre todas las tematicas en el mismo instante

Con el "mismo instante" me refiero a que si se manda el mensaje se hace todo directo,
no es que por cada vez que se manda el mensaje emitir se trata solo la primera de la lista 
*/

    method emitir() {
        tematicas.forEach {unaTematica => self.panelistasOpinanSobre(unaTematica)}
        emisionCompleta = true
    }

    method panelistasOpinanSobre(unaTematica) {
        panelistas.forEach {unPanelista => unPanelista.tratar(unaTematica)}

    }

    method concluyo() = tematicas.isEmpty()

    method panelistaEstrella() {
        self.verificarTerminoEmision()

        self.panelistaConMasEstrellas()
    }

    method verificarTerminoEmision() {
        if(! emisionCompleta) {
            throw new DomainException(message = "El programa no finalizo, no se puede calcular el participante")
        }
    }

    method panelistaConMasEstrellas() = panelistas.max {unPanelista => unPanelista.puntosEstrella()}
}

