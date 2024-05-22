data Serie = Serie {
    nombreSerie :: String,
    actores :: [Actor],
    presupuesto :: Int,
    cantidadTemporadas :: Int,
    ratingPromedio :: Float,
    cancelada :: Bool
}

data Actor = Actor {
    nombreActor :: String,
    sueldoAnual :: Int,
    restricciones :: [Restriccion]
}

type Restriccion = Actor -> Bool

-------------
-- Punto 1 --
-------------

estaEnRojo :: Serie -> Bool
estaEnRojo unaSerie = presupuesto unaSerie > sumaSueldos (actores unaSerie)

sumaSueldos :: [Actor] -> Int
sumaSueldos listaDeActores = sum (map sueldoAnual listaDeActores)

esProblematica :: Serie -> Bool
esProblematica unaSerie = (>3) . length . actoresConMasDeUnaRestriccion $ actores unaSerie 

actoresConMasDeUnaRestriccion :: [Actor] -> [Actor]
actoresConMasDeUnaRestriccion  = filter ((>1) . length . restricciones)

