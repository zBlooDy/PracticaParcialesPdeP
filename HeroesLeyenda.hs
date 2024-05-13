-- Punto 1) ======================

data Artefacto = Artefacto {
    nombre :: String,
    rareza :: Int
} deriving (Eq,Show)

data Heroe = Heroe {
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto]
} deriving (Eq,Show)

-- Punto 2) ================================

cambiaEpiteto nuevoEpiteto heroe = heroe {epiteto = nuevoEpiteto} 

agregaArtefacto nuevoArtefacto rareza heroe = heroe {artefactos = artefactos heroe ++ [Artefacto nuevoArtefacto rareza] }


rocko = Heroe {
    epiteto = "Rockito",
    reconocimiento = 90,
    artefactos = []
} 

paseALaHistoria unHeroe 
    | reconomientoDeHeroe > 1000 = cambiaEpiteto "El mitico" unHeroe
    | reconomientoDeHeroe >= 500  = cambiaEpiteto "El magnifico" $ agregaArtefacto "Lanza Del Olimpo" 100 unHeroe
    | reconomientoDeHeroe > 100  = cambiaEpiteto "Hoplita" $ agregaArtefacto "Xiphos" 50 unHeroe
    | otherwise                     = unHeroe
    where
        reconomientoDeHeroe = reconocimiento unHeroe