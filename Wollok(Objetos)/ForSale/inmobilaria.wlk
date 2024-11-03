object inmobiliaria {
    const empleados = []

    method mejorEmpleadoSegun(criterio) = empleados.max {unEmpleado => criterio.calificacionSegun(unEmpleado)} 



}

class Empleado {
    const operacionesCerradas = []
    const reservas = []

    method totalDeComisiones() = operacionesCerradas.sum {unaOperacion => unaOperacion.comision()}

    method agregarOperacion(unaOperacion) {
        operacionesCerradas.add(unaOperacion)
    }

    method agregarReserva(unaReserva) {
        reservas.add(unaReserva)
    }

    method cantidadOperacionesCerradas() = operacionesCerradas.size()

    method cantidadDeReservas() = reservas.size()

    method tieneProblemasCon(otroEmpleado) = self.cerraronOperacionesEnMismaZona(otroEmpleado) || self.cerroOperacionDe(otroEmpleado)

    method cerraronOperacionesEnMismaZona(otroEmpleado) {
        const zonas = self.zonasDeOperaciones()
        const otrasZonas = otroEmpleado.zonasDeOperaciones()
        return zonas.any {unaZona => otrasZonas.contains(unaZona)}
    }

    method zonasDeOperaciones() = operacionesCerradas.map {unaOperacion => unaOperacion.zona()}

    method cerroOperacionDe(otroEmpleado) = operacionesCerradas.any {unaOperacion => otroEmpleado.ibaACerrar(unaOperacion)}

    method ibaACerrar(unaOperacion) = reservas.contains(unaOperacion)
}

object totalComisiones {
    method calificacionSegun(unEmpleado) = unEmpleado.totalDeComisiones()
}

object cantidadOpCerradas {
    method calificacionSegun(unEmpleado) = unEmpleado.cantidadOperacionesCerradas()
}

object cantidadReservas {
    method calificacionSegun(unEmpleado) = unEmpleado.cantidadDeReservas()
}