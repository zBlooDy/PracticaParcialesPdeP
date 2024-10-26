import niveles.*
class Usuario {
    const productosEnCarrito
    const cupones
    var nivel
    var dinero
    var puntos

    method agregarProducto(unProducto) {
        self.verificarEspacioSegunNivel()

        productosEnCarrito.add(unProducto)
    }

    method verificarEspacioSegunNivel() {
        if(!nivel.permiteAgregarEn(productosEnCarrito)){
            throw new DomainException(message = "Carrito lleno para tu nivel")
        }
    }


    method comprarCarrito() {
        const cuponAleatorio = self.tomarCuponAleatorio()
        
        cuponAleatorio.usar()
        const precioDescontado = cuponAleatorio.aplicarDescuento(self.precioDelCarrito())

        self.disminuirDinero(precioDescontado)
        self.sumarPuntos(precioDescontado * 0.1)
    }

    method tomarCuponAleatorio() {
        return cupones.filter({unCupon => unCupon.libre()}).anyOne()
    }

    method precioDelCarrito() {
        return productosEnCarrito.sum({unProducto => unProducto.precio()})
    }

    method disminuirDinero(unaCantidad) {
        dinero =- unaCantidad
    }

    method sumarPuntos(unaCantidad) {
        puntos =+ unaCantidad
    }

//  Metodos para los requisitos

    method esMoroso() {
        return dinero < 0
    }

    method reducirPuntos(unaCantidad) {
        puntos =- unaCantidad
    }

    method sacarUsados() {
        cupones.remove({unCupon => ! unCupon.libre()})
    }

    method actualizarNivel() {
        nivel = self.nivelCorrespondiente()
    }

    method nivelCorrespondiente() {
        if (puntos < 5000) {
            return nivelBronce
        } else if(puntos < 15000) {
            return nivelPlata
        } else {
            return nivelOro
        }
    }

}



class Cupon {

    var fueUtilizado = false
    const porcentajeDescuento

    method aplicarDescuento(unPrecio) {
        return unPrecio - unPrecio * porcentajeDescuento
    }

    method usar() {
        fueUtilizado = true
    }

    method libre() {
        return !fueUtilizado 
    }

}