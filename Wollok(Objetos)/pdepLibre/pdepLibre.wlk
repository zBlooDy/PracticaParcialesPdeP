import niveles.*
import usuarios.*
import productos.*


object pdepLibre {
    const usuarios = #{}
    const productos = #{}

    method reducirPuntosAMorosos() {
        usuarios
        .forEach({unUsuario => unUsuario.reducirPuntos(1000)})
        .filter({unUsuario => unUsuario.esMoroso()})
    }

    method sacarCuponesUsados() {
        usuarios.forEach({unUsuario => unUsuario.sacarUsados()})
    }

    method nombresOferta() {
        productos.forEach({unProducto => unProducto.nombreOferta()})
    }


    method actualizarNiveles() {
        usuarios.forEach({unUsuario => unUsuario.actualizarNivel()})
    }
}