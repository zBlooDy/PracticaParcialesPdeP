class Revolver {

    var cantidadBalas

    method hacerDanio(unaVictima) {
        self.disparar(unaVictima)
        self.gastarBala()
    }

    method disparar(unaVictima) {
        if(cantidadBalas > 0) {
            unaVictima.morir()
        } 
    }

    method gastarBala() {
        cantidadBalas =- 1
    }

    //method recargar() ?

    method esSutil() = cantidadBalas == 1
}

class Escopeta {

    method hacerDanio(unaVictima) {
        unaVictima.herir()
    }

    method esSutil() = false
}

class CuerdaDePiano {
    const buenaCalidad

    method hacerDanio(unaVictima) {
        if(buenaCalidad) {
            unaVictima.morir()
        }
    }

    method esSutil() = true
}