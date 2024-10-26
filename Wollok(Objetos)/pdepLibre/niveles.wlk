/*Si hago clases de Niveles, voy a necesitar instanciar a cada nivel (bronce, plata, oro)
por lo que es lo mismo que haga objetos
*/

object nivelBronce {
    const productosMaximos = 1

    method permiteAgregarEn(carrito) {
        return carrito.size() < productosMaximos
    }



}

object nivelPlata {
    const productosMaximos = 5

    method permiteAgregarEn(carrito) {
        return carrito.size() < productosMaximos
    }


}

object nivelOro {
    

    method permiteAgregarEn(carrito) {
        return true
    }


}