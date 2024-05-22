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

-------------
-- Punto 2 --
-------------
type Produccion = Serie -> Serie

conFavoritismos :: [Actor] -> Produccion
conFavoritismos listaFavoritos = agregaActores listaFavoritos . sacarActores 2 

sacarActores :: Int -> Serie -> Serie
sacarActores cantidad = mapActores (drop cantidad)

agregaActores :: [Actor] -> Serie -> Serie
agregaActores listaActores = mapActores (listaActores ++)

mapActores :: ([Actor] -> [Actor]) -> Serie -> Serie
mapActores f unaSerie = unaSerie {actores = f $ actores unaSerie}

johnnydepp :: Actor
johnnydepp = Actor{
    nombreActor = "Johnny Depp",
    sueldoAnual = 20000000,
    restricciones = []
}

helenabonham :: Actor
helenabonham = Actor {
    nombreActor = "Helena Bonham",
    sueldoAnual = 15000000,
    restricciones = []
}

timBurton :: Produccion
timBurton = conFavoritismos [johnnydepp, helenabonham]

gatoPardeitor :: Produccion
gatoPardeitor unaSerie = unaSerie 

estireitor :: Produccion
estireitor = duplicarTemporadas

duplicarTemporadas :: Serie -> Serie
duplicarTemporadas = mapTemporadas (*2)

mapTemporadas :: (Int -> Int) -> Serie -> Serie
mapTemporadas f unaSerie = unaSerie {cantidadTemporadas = f $ cantidadTemporadas unaSerie}


desespereitor :: [Produccion] -> Produccion
desespereitor listaProducciones unaSerie = foldl (\x f -> f x) unaSerie listaProducciones

canceleitor :: Float -> Produccion
canceleitor cifra unaSerie 
    | estaEnRojo unaSerie || ratingPromedio unaSerie < cifra  = unaSerie {cancelada = True}
    | otherwise                                               = unaSerie
