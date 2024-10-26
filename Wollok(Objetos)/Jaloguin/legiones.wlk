class Legion {

    const grupoNinios = []

    method capacidadAsustar() = grupoNinios.sum {unNinio => unNinio.capacidadParaAsustar()}

    method cantidadCaramelos() = grupoNinios.sum {unNinio => unNinio.caramelos()}


    method sonSuficientes() {
        if(!grupoNinios.size() > 2) {
            throw new DomainException(message = "Son poquitos che")
        }
    }
    // No esta bien pero no se como implementar que agregue los caramelos que van sacando de los adultos
    method asustanA(unaPersona) {
        const niniosDespuesDeAsustar = grupoNinios.forEach ({unNinio => unNinio.asustarA(unaPersona)})
        const caramelosTotales       = niniosDespuesDeAsustar.sum ({unNinio => unNinio.caramelos()})
        self.lider().agregarCaramelos(caramelosTotales)
    }

    method lider() = grupoNinios.max {unNinio => unNinio.capacidadParaAsustar()}


    //Legion de legiones?
    /*Creo que se deberia usar flatten para tener una unica lista, y despues hacer como lo hice.
    Ni idea como implementar flatten
    */
}