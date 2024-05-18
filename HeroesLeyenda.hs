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

relampagoZeus = Artefacto {
    nombre = "El relampago de Zeus",
    rareza = 500
}

escalarOlimpo :: Heroe -> Heroe
escalarOlimpo = agregaArtefacto relampagoZeus . desechaArtefactos . triplicaRareza . sumaReconocimiento 500 

mapRarezaArtefacto :: (Int -> Int) -> Artefacto -> Artefacto
mapRarezaArtefacto f unArtefacto = unArtefacto {rareza = f $ rareza unArtefacto }

triplicaRareza :: Heroe -> Heroe
triplicaRareza = mapArtefacto (map (mapRarezaArtefacto (*3)))

desechaArtefactos :: Heroe -> Heroe
desechaArtefactos = mapArtefacto (filter ((>1000) . rareza))

-- <- Ayudar a cruzar la calle ->


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

-- Punto 4) ================================

heracles :: Heroe
heracles = Heroe {
    epiteto = "Guardian del Olimpo",
    reconocimiento = 700,
    artefactos = [relampagoZeus, Artefacto "Pistola" 1000],
    tareas = [matarLeonNemea]
}

-- Punto 5) ================================

leonNemea :: Bestia
leonNemea = Bestia {
    nombreBestia = "Leon de Nemea",
    debilidad = epitetoMayorVeinte 
}

epitetoMayorVeinte :: Heroe -> Bool
epitetoMayorVeinte = (>20) . length . epiteto 

matarLeonNemea :: Heroe -> Heroe
matarLeonNemea = matarUnaBestia leonNemea  

-- Punto 6) ================================
agregarTarea :: (Heroe -> Heroe) -> Heroe -> Heroe
agregarTarea unaTarea = mapTareas (unaTarea :)

mapTareas :: ([Heroe -> Heroe] -> [Heroe -> Heroe]) -> Heroe -> Heroe
mapTareas f unHeroe = unHeroe {tareas = f $ tareas unHeroe}

hacerUnaTarea ::  Heroe -> (Heroe -> Heroe) -> Heroe
hacerUnaTarea unHeroe unaTarea  = agregarTarea unaTarea . unaTarea $ unHeroe

-- Punto 7) ================================
presumenLogros :: Heroe -> Heroe -> (Heroe, Heroe)
presumenLogros unHeroe otroHeroe
    | reconocimiento unHeroe > reconocimiento otroHeroe     = (unHeroe , otroHeroe)
    | reconocimiento unHeroe < reconocimiento otroHeroe     = (otroHeroe , unHeroe)
    | sumatoriaRarezas unHeroe > sumatoriaRarezas otroHeroe =  (unHeroe , otroHeroe)
    | sumatoriaRarezas unHeroe < sumatoriaRarezas otroHeroe =  (otroHeroe , unHeroe)
    | otherwise                                             = presumenLogros (realizanTareasDelOtro unHeroe otroHeroe) (realizanTareasDelOtro otroHeroe unHeroe)

sumatoriaRarezas :: Heroe -> Int
sumatoriaRarezas unHeroe = sum (map rareza $ artefactos unHeroe)

realizanTareasDelOtro :: Heroe -> Heroe -> Heroe
realizanTareasDelOtro heroe1 heroe2 = foldl hacerUnaTarea heroe1 (tareas heroe2)

-- Punto 8) ================================

    --No va a devolver ningun resultado, ya que, se va a quedar evaluando constantemente por el ultimo caso en el que realizan las tareas del otro

-- Punto 9) ================================

type Labor = [Heroe -> Heroe]

realizarUnaLabor :: Heroe -> Labor -> Heroe
realizarUnaLabor = foldl hacerUnaTarea 

-- Punto 10) ================================
    -- No, ya que se va a quedar evaluando constantemente y nunca va a poder arrojar un resultado.