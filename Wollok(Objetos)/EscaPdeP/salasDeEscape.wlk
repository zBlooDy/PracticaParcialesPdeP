class SalaDeEscape {
    
    const dificultad

    const nombre

    method precio() = 10000

    method dificil() = dificultad > 7

    method nombre() = nombre
}

class Anime inherits SalaDeEscape {

    override method precio() = super() + 7000

}

class Historia inherits SalaDeEscape {

    const estaBasadaEnHechosReales

    override method precio() = super() + 0.314 * dificultad

    override method dificil() = super() and !estaBasadaEnHechosReales
}

class Terror inherits SalaDeEscape {

    const sustos
    
    override method precio() = super() + self.valorAdicional()
    
    method valorAdicional() {
        if(self.haySuficientesSustos()) {
            return self.precio() * 0.2
        } else {
            return 0
        }
    }

    method haySuficientesSustos() = sustos > 5

    override method dificil() = super() or sustos > 5

}