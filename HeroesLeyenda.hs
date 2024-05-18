import Text.Show.Functions

-- Punto 1) ======================

data Artefacto = Artefacto {
    nombre :: String,
    rareza :: Int
} deriving (Eq,Show)

data Heroe = Heroe {
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Heroe -> Heroe]
} deriving (Show)

-- Punto 2) ================================

cambiaEpiteto :: String -> Heroe -> Heroe
cambiaEpiteto nuevoEpiteto  = mapEpiteto (const nuevoEpiteto)

mapEpiteto :: (String -> String) -> Heroe -> Heroe
mapEpiteto f unHeroe = unHeroe {epiteto = f $ epiteto unHeroe}

agregaArtefacto :: Artefacto -> Heroe -> Heroe
agregaArtefacto nuevoArtefacto = mapArtefacto (nuevoArtefacto :) 

mapArtefacto :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
mapArtefacto f unHeroe = unHeroe {artefactos = f $ artefactos unHeroe} 



paseALaHistoria :: Heroe -> Heroe
paseALaHistoria unHeroe 
    | reconomientoDeHeroe > 1000    = cambiaEpiteto "El mitico" unHeroe
    | reconomientoDeHeroe >= 500    = cambiaEpiteto "El magnifico" . agregaArtefacto (Artefacto "Lanza Del Olimpo" 100) $ unHeroe
    | reconomientoDeHeroe > 100     = cambiaEpiteto "Hoplita" . agregaArtefacto (Artefacto "Xiphos" 50)  $ unHeroe
    | otherwise                     = unHeroe
    where
        reconomientoDeHeroe = reconocimiento unHeroe

-- Punto 3) ================================

-- <- Encontrar un artefacto ->
encontrarUnArtefacto :: Artefacto -> Heroe -> Heroe
encontrarUnArtefacto unArtefacto  = sumaReconocimiento (rareza unArtefacto) . agregaArtefacto unArtefacto 

sumaReconocimiento :: Int -> Heroe -> Heroe
sumaReconocimiento unReconocimiento = mapReconocimiento (+ unReconocimiento)

mapReconocimiento :: (Int -> Int) -> Heroe -> Heroe
mapReconocimiento f unHeroe = unHeroe {reconocimiento = f $ reconocimiento unHeroe}

-- <- Escalar el olimpo ->

escalarOlimpo :: Heroe -> Heroe
escalarOlimpo = agregaArtefacto (Artefacto "El relampago de Zeus" 500) . desechaArtefactos . triplicaRareza . sumaReconocimiento 500 

mapRarezaArtefacto :: (Int -> Int) -> Artefacto -> Artefacto
mapRarezaArtefacto f unArtefacto = unArtefacto {rareza = f $ rareza unArtefacto }

triplicaRareza :: Heroe -> Heroe
triplicaRareza = mapArtefacto (map (mapRarezaArtefacto (*3)))

desechaArtefactos :: Heroe -> Heroe
desechaArtefactos = mapArtefacto (filter ((>1000) . rareza))

-- <- Ayudar a cruzar la calle ->

rocko = Heroe {
    epiteto = "rocko",
    reconocimiento = 1000,
    artefactos = [],
    tareas = []
}

ayudarACruzarCalle :: Int -> Heroe -> Heroe
ayudarACruzarCalle cantidadCalles = cambiaEpiteto ("Gros" ++ replicate cantidadCalles 'o')

data Bestia = Bestia {
    nombreBestia :: String,
    debilidad :: Heroe -> Bool
}

matarUnaBestia :: Bestia -> Heroe -> Heroe
matarUnaBestia unaBestia unHeroe
    | debilidad unaBestia unHeroe = cambiaEpiteto ("El asesino de " ++ nombreBestia unaBestia) unHeroe
    | otherwise                   = cambiaEpiteto "El cobarde" . mapArtefacto (drop 1) $ unHeroe
