class Barrio {

    const niniosQueHabitan = []

    method niniosConMasCaramelos() = niniosQueHabitan.sortBy{unNinio, otroNinio => unNinio.caramelos() > otroNinio.caramelos()}.take(3)

    method elementosMasUsados() {
        const niniosConMuchosCaramelos = niniosQueHabitan.filter {unNinio =>unNinio.caramelos() > 10}
        const elementosNinios = niniosConMuchosCaramelos.flatMap {unNinio => unNinio.elementosUsados()}
        return elementosNinios.asSet()
    }

    
}