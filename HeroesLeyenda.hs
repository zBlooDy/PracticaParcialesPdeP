
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

cambiaEpiteto :: String -> Heroe -> Heroe
cambiaEpiteto nuevoEpiteto  = mapEpiteto (const nuevoEpiteto)

mapEpiteto :: (String -> String) -> Heroe -> Heroe
mapEpiteto f unHeroe = unHeroe {epiteto = f $ epiteto unHeroe}

agregaArtefacto :: Artefacto -> Heroe -> Heroe
agregaArtefacto nuevoArtefacto = mapArtefacto (nuevoArtefacto :) 

mapArtefacto :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
mapArtefacto f unHeroe = unHeroe {artefactos = f $ artefactos unHeroe} 


sube = Artefacto {
    nombre = "La poderosa Sube",
    rareza = 9000
}

rocko = Heroe {
    epiteto = "Rockito",
    reconocimiento = 700,
    artefactos = [sube]
}

paseALaHistoria :: Heroe -> Heroe
paseALaHistoria unHeroe 
    | reconomientoDeHeroe > 1000    = cambiaEpiteto "El mitico" unHeroe
    | reconomientoDeHeroe >= 500    = cambiaEpiteto "El magnifico" . agregaArtefacto (Artefacto "Lanza Del Olimpo" 100) $ unHeroe
    | reconomientoDeHeroe > 100     = cambiaEpiteto "Hoplita" . agregaArtefacto (Artefacto "Xiphos" 50)  $ unHeroe
    | otherwise                     = unHeroe
    where
        reconomientoDeHeroe = reconocimiento unHeroe

