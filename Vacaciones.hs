data Turista = Turista {
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [Idioma]
}

type Idioma = String

type Excursion = Turista -> Turista

irALaPlaya :: Excursion
irALaPlaya unTurista
  | viajaSolo unTurista = reduceCansancio 5 unTurista
  | otherwise           = reduceStress 1 unTurista

aumentaCansancio :: Int -> Turista -> Turista
aumentaCansancio unCansancio = mapCansancio (unCansancio +)

reduceCansancio :: Int -> Turista -> Turista
reduceCansancio unCansancio = mapCansancio (subtract unCansancio)

mapCansancio :: (Int -> Int) -> Turista -> Turista
mapCansancio f unTurista = unTurista {cansancio = f $ cansancio unTurista}

aumentaStress :: Int -> Turista -> Turista
aumentaStress unStress = mapStress (+ unStress)

reduceStress :: Int -> Turista -> Turista
reduceStress unStress = mapStress (subtract unStress)

mapStress :: (Int -> Int) -> Turista -> Turista
mapStress f unTurista = unTurista {stress = f $ stress unTurista}


apreciarElementoPaisaje :: String -> Excursion
apreciarElementoPaisaje elementoPaisaje = reduceStress $ length elementoPaisaje


salirHablarUnIdioma :: String -> Excursion
salirHablarUnIdioma unIdioma = viajarAcompaniado . aprendeIdioma unIdioma

viajarAcompaniado :: Turista -> Turista
viajarAcompaniado unTurista = unTurista {viajaSolo = False}

aprendeIdioma :: Idioma -> Turista -> Turista
aprendeIdioma unIdioma = mapIdiomas (unIdioma :)

mapIdiomas :: ([Idioma] -> [Idioma]) -> Turista -> Turista
mapIdiomas f unTurista = unTurista {idiomas = f $ idiomas unTurista}


caminar :: Int -> Excursion
caminar minutos = aumentaCansancio (intensidad minutos) . reduceStress (intensidad minutos)


intensidad :: Int -> Int
intensidad minutos = div minutos 4

data Marea = Fuerte | Moderada | Tranquila deriving(Eq)

paseoEnBarco :: Marea -> Excursion
paseoEnBarco marea unTurista
    | marea == Fuerte   = aumentaStress 6 . aumentaCansancio 10 $ unTurista
    | marea == Moderada = unTurista
    | otherwise         = salirHablarUnIdioma "Aleman" . apreciarElementoPaisaje "mar" . caminar 10 $ unTurista


------------
--Punto 1---
------------

ana :: Turista
ana = Turista 0 21 False ["Espaniol"] 

beto :: Turista
beto = Turista 15 15 True ["Aleman"]

cathi :: Turista
cathi = Turista 15 15 True ["Aleman", "Catalan"]


------------
--Punto 2--
------------

hacerUnaExcursion :: Excursion -> Turista -> Turista
hacerUnaExcursion unaExcursion unTurista = reduceStress (porcentajeDeStress 10 unTurista) . unaExcursion $ unTurista

porcentajeDeStress :: Int -> Turista -> Int
porcentajeDeStress porcentaje = div porcentaje . stress 


deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2


deltaExcursionSegun :: (Turista -> Int) -> Excursion -> Turista -> Int
deltaExcursionSegun indice unaExcursion unTurista = deltaSegun indice (hacerUnaExcursion unaExcursion unTurista) unTurista


esEducativa :: Excursion -> Turista -> Bool
esEducativa unaExcursion unTurista= (== 1) $ deltaExcursionSegun (length . idiomas) unaExcursion unTurista

 
excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes unTurista = filter (esDesestresantePara unTurista)

esDesestresantePara :: Turista -> Excursion -> Bool
esDesestresantePara unTurista unaExcursion = (<= (-3)) $ deltaExcursionSegun stress unaExcursion unTurista