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
esProblematica unaSerie = (>3) .  actoresConXRestricciones 2 $ actores unaSerie 

actoresConXRestricciones :: Int -> [Actor] -> Int
actoresConXRestricciones cantidad = length . filter ((>= cantidad) . length . restricciones)

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

-------------
-- Punto 3 --
-------------

bienestarSerie :: Serie -> Int
bienestarSerie (Serie _ _ _ _ _ True) = 0

bienestarTotalSerie :: Serie -> Int
bienestarTotalSerie unaSerie = bienestarSegunTemporadas unaSerie + bienestarSegunActores unaSerie 

bienestarSegunTemporadas :: Serie -> Int
bienestarSegunTemporadas (Serie _ _ cantidadTemporadas _ _ _) 
    | (>4)  cantidadTemporadas  = 5
    | otherwise                 = (10 - cantidadTemporadas) * 2

bienestarSegunActores :: Serie -> Int
bienestarSegunActores (Serie _ actores _ _ _ _)
    | (<10) . length  $ actores = 3
    | otherwise                 = 10 - actoresConXRestricciones 2 actores  

-------------
-- Punto 4 --
-------------

aplicaSeriesEfectivas :: [Serie] -> [Produccion] -> [Serie]
aplicaSeriesEfectivas listaSeries listaProductores = map (produccionMasEfectiva listaProductores)  listaSeries 


produccionMasEfectiva :: [Produccion] -> Serie -> Serie
produccionMasEfectiva [produccion] unaSerie = produccion unaSerie
produccionMasEfectiva (produccion1:produccion2:producciones) unaSerie
    | bienestarTotalSerie (produccion1 unaSerie) > bienestarTotalSerie (produccion2 unaSerie) = produccionMasEfectiva (produccion1:producciones) unaSerie
    | otherwise = produccion2 unaSerie