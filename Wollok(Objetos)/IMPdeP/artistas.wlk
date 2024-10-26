class Artista {

    var cantidadPeliculasFilmadas
    var experiencia
    var ahorros

    method fama() {
        return cantidadPeliculasFilmadas / 2
    }

    method sueldo() {
        return experiencia.sueldo(self.fama(), cantidadPeliculasFilmadas)
    }

    method recategorizar() {
       experiencia = experiencia.recategorizarA(self.fama(), cantidadPeliculasFilmadas) 
    }

    method actuar() {
        cantidadPeliculasFilmadas += 1
        ahorros += self.sueldo()
    }
}

object amateur {

    method sueldo(_fama, _cantidadPeliculas) {
        return 10000
    }

    method recategorizarA(_fama, cantidadPeliculas) {
        if(cantidadPeliculas > 10) {
            return establecida
        } else {
            return self
        }
    }
}

object establecida {

    method sueldo(fama, _cantidadPeliculas) {
        if(fama < 15) {
            return 15000
        } else {
            return 5000 * fama
        }
    }

    method recategorizarA(fama, _cantidadPeliculas) {
        if(fama > 10) {
            return estrella
        } else {
            return self
        }
    }
}

object estrella {

    method sueldo(_fama, cantidadPeliculas) {
        return 30000 * cantidadPeliculas
    }

    method recategorizarA(_fama, _cantidadPeliculas) {
        throw new DomainException(message = "Ya sos la maquina pa")
    }
}