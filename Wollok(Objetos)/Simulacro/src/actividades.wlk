class TomarVino {

    method afectarA(unFilosofo) {
        unFilosofo.disminuirIluminacion(10)
        unFilosofo.agregarHonorifico("el borracho")
    }
}

class JuntarseEnElAgora {
    const otroFilosofo

    method afectarA(unFilosofo) {
        unFilosofo.aumentarIluminacion(0.1 * otroFilosofo.nivelIluminacion())
    }
}

class AdmirarPaisaje {
    method afectarA(_unFilosofo) {}

}

class MeditarBajoCascada {
    const metrosCascada

    method afectarA(unFilosofo) {
        unFilosofo.aumentarIluminacion(10 * metrosCascada)
    }
}

class PracticarDeporte {
    const tipoDeporte

    method afectarA(unFilosofo) {
        unFilosofo.rejuvenecer(tipoDeporte.dias())
    }
}

object futbol {
    method dias() = 1
}

object polo {
    method dias() = 2
}

object waterpolo {
    method dias() = polo.dias() * 2
}