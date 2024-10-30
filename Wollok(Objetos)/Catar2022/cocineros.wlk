import platos.*

class Cocinero {

    var especialidad

    method catar(unPlato) = especialidad.calificacionDe(unPlato)

    method especialidad(nuevaEspecialidad) {
        especialidad = nuevaEspecialidad
    }

    method cocinarPlato() = especialidad.cocinar(self)

    method participar(unTorneo) {
        const plato = self.cocinarPlato()
        unTorneo.agregarPlato(plato)
    }
}

class Pastelero {
    const dulzorDeseado

    method calificacionDe(unPlato) = 10.max(5 * unPlato.azucar() / dulzorDeseado)

    method cocinar(unCocinero) = new Postre(autor = unCocinero, cantidadColores = dulzorDeseado / 50)
}

class Chef {
    const caloriasMaximas

    method platoPerfecto(unPlato) = unPlato.esBonito() and unPlato.calorias() <= caloriasMaximas

    method calificacionDe(unPlato) {
        if(self.platoPerfecto(unPlato)) {
            return 10
        } else {
            self.calificacionInsuficiente(unPlato)
        }
    }

    method calificacionInsuficiente(_unPlato) = 0

    method cocinar(unCocinero) = new Principal(autor = unCocinero, azucar = caloriasMaximas, bonito = true)
}

class SousChef inherits Chef {

    override method calificacionInsuficiente(unPlato) = 6.max(unPlato.calorias() / 100)

    override method cocinar(unCocinero) = new Entrada(autor = unCocinero)
}