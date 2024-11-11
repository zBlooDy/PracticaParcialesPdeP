class Mision {
    const peligrosidad

    const habilidadesRequeridas = []

    method puedeRealizarla(unEmpleado) = unEmpleado.esCapazDeUsar(habilidadesRequeridas)

    method sonCapaces(unEquipo) = unEquipo.algunoEsCapaz(habilidadesRequeridas)

    method afectarA(unEmpleado) {
        if(self.puedeRealizarla(unEmpleado)) {
            unEmpleado.disminuirVida(peligrosidad)
        }
    }

    method afectarATodos(unEquipo) {
        if(self.sonCapaces(unEquipo)) {
            unEquipo.pierdenVida(peligrosidad/3)
        }
    }

    method habilidadesRequeridas() = habilidadesRequeridas
}