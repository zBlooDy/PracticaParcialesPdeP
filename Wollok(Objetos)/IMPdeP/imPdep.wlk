import artistas.*
import peliculas.*

object imPdeP {
    const artistas = #{}
    const peliculas = #{}


    method artistaMejorPago() {
        return artistas.max({artista => artista.sueldo()})
    }

    method peliculasEconomicas() {
        return peliculas.filter({pelicula => pelicula.economica()})
    }

    method gananciaPeliculasEconomicas() {
        return peliculas 
        .filter({pelicula => pelicula.economica()})
        .sum({pelicula => pelicula.ganancia()})
    }
}