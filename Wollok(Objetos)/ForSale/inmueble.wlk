class Inmueble {

    const property zona
    const metrosCuadrados
    const ambientes

    method valor() = self.precio() + zona.precioPorZona() 

    method precio()


}   

class Casa inherits Inmueble {
    const precio

    override method precio() = precio
}

class PH inherits Inmueble{
    
    override method precio() = 500000.min(14000 * metrosCuadrados)
}

class Departamento inherits Inmueble {

    override method precio() = 35000 * ambientes
}

class Zona {
    const valor

    method precioPorZona() = valor
}