object jarl {

    method permiteSubir(unVikingo) = ! unVikingo.tieneArmas()

    method ascenderPor(unVikingo) {
        unVikingo.casta(karl)
        unVikingo.recompensa()
    } 
}

object karl {

    method permiteSubir() = true

    method ascenderPor(unVikingo) {
        unVikingo.casta(thrall)
    }
}

object thrall {

    method permiteSubir() = true

    method ascenderPor(unVikingo) {}
}