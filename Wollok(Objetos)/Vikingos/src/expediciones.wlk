class Expedicion {
    const integrantes 
    const objetivos = []
    
    method agregarVikingo(unVikingo) {
        integrantes.add(unVikingo)
    }

    method cantidadVikingos() = integrantes.size()

    method tieneUnGranBotin() = objetivos.all {unObjetivo => unObjetivo.valeLaPenaInvadir(self.cantidadVikingos())} 

    method realizar() = objetivos.forEach {unObjetivo => unObjetivo.invadidoPor(integrantes)}
}

// creo q repito un poco de logica, nt

class Botin {

    method repartirBotin(unosVikingos, unBotin) {
        const cantidadVikingos = unosVikingos.size()
        unosVikingos.forEach {unVikingo => unVikingo.agregarMonedas(unBotin / cantidadVikingos)}
    }
}

class Capital inherits Botin {
    var defensores
    const factorRiqueza

    method valeLaPenaInvadir(cantidadVikingos) = self.monedasPara(cantidadVikingos) > 3
    
    method monedasPara(cantidadVikingos) = cantidadVikingos / self.botin() 

    method botin() = defensores * factorRiqueza

    method invadidoPor(unosVikingos) {
        unosVikingos.forEach {unVikingo => unVikingo.cobraUnaVida()}
        defensores =- unosVikingos.size()
        self.repartirBotin(unosVikingos, self.botin())
    }

}

class Aldea inherits Botin {
    var cantidadCrucifijos

    method valeLaPenaInvadir(cantidadVikingos) = cantidadCrucifijos >= 15

    method invadidoPor(unosVikingos) {
        self.repartirBotin(unosVikingos, cantidadCrucifijos)
        cantidadCrucifijos = 0
    }
}


class AldeaConMuralla inherits Aldea {
    const vikingosMinimos

    override method valeLaPenaInvadir(cantidadVikingos) = super(cantidadVikingos) && cantidadVikingos >= vikingosMinimos 

}


/* 4)
Si, se puede agregar los castillos, por el concepto de polimorfismo no vamos a tener que modificar codigo,
simplemente agregamos la logica que tenga el Castillo 
*/