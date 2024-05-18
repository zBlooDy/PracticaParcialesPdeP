-- DATAS ======================================================
import Text.Show.Functions
import Data.List(genericLength)
import Data.Char(isUpper)
import Data.ByteString (unpack)

data Plomero = Plomero {
    nombre :: String,
    cajaDeHerramientas :: [Herramienta],
    historialReparaciones :: [Reparacion],
    cantidadDinero :: Float
} deriving (Show)

data Herramienta = Herramienta {
    denominacion :: String,
    precio :: Float,
    materialEmpuniadura :: Material
} deriving (Show,Eq)

data Material = Hierro | Madera | Goma | Plastico deriving (Show,Eq)


-- PUNTO 1 ======================================================

llaveInglesa = Herramienta {
    denominacion = "Llave inglesa",
    precio = 200,
    materialEmpuniadura = Hierro
}


martillo = Herramienta {
    denominacion = "Martillo",
    precio = 20,
    materialEmpuniadura = Madera
}

llaveFrancesa = Herramienta {
    denominacion = "Llave francesa",
    precio = 1,
    materialEmpuniadura = Hierro
}

mario = Plomero {
    nombre = "Mario",
    cajaDeHerramientas = [llaveInglesa, martillo],
    historialReparaciones = [],
    cantidadDinero = 1200
}

wario = Plomero {
    nombre = "Wario",
    cajaDeHerramientas = repeat llaveFrancesa,
    historialReparaciones = [],
    cantidadDinero = 0.5
}


-- Falta Wario que parece que hay que usar una lista infinita

-- PUNTO 2 ======================================================

tieneHerramienta :: Herramienta -> Plomero -> Bool
tieneHerramienta unaHerramienta unPlomero = elem unaHerramienta $ cajaDeHerramientas unPlomero

esMalvado :: Plomero -> Bool
esMalvado unPlomero = ("Wa" ==).take 2 $ nombre unPlomero

puedeComprar :: Plomero -> Herramienta -> Bool
puedeComprar unPlomero unaHerramienta = cantidadDinero unPlomero >= precio unaHerramienta

-- PUNTO 3 ======================================================

esBuenaHerramienta (Herramienta _ precio Hierro) = precio >= 10000
esBuenaHerramienta (Herramienta "Martillo" _ Madera) = True
esBuenaHerramienta (Herramienta "Martillo" _ Goma) = True
esBuenaHerramienta _ = False

-- PUNTO 4 ======================================================

comprarHerramienta :: Plomero -> Herramienta -> Plomero
comprarHerramienta unPlomero unaHerramienta 
    | puedeComprar unPlomero unaHerramienta = quitaDinero (precio unaHerramienta) . agregaHerramienta unaHerramienta $ unPlomero
    | otherwise                             = unPlomero


agregaHerramienta :: Herramienta -> Plomero -> Plomero
agregaHerramienta unaHerramienta  = mapHerramienta ((:) unaHerramienta) 

mapHerramienta :: ([Herramienta] -> [Herramienta]) -> Plomero -> Plomero
mapHerramienta f unPlomero = unPlomero {cajaDeHerramientas = f $ cajaDeHerramientas unPlomero}

quitaDinero :: Float -> Plomero -> Plomero
quitaDinero unDinero  = mapDinero (subtract unDinero) 

mapDinero :: (Float -> Float) -> Plomero -> Plomero
mapDinero f unPlomero = unPlomero {cantidadDinero = f $ cantidadDinero unPlomero}

-- PUNTO 5 ======================================================

data Reparacion = Reparacion {
    descripcion :: String,
    requerimiento :: Plomero -> Bool   
} deriving (Show)

--a) 
filtracionAgua :: Reparacion
filtracionAgua = Reparacion {
    descripcion = "Filtracion de agua",
    requerimiento = tieneHerramienta llaveInglesa 
}

--b)
esDificil :: Reparacion -> Bool
esDificil (Reparacion descripcion _) = length descripcion > 100 && todasMayusculas descripcion
 
todasMayusculas = all isUpper 

--c) 
presupuestoReparacion :: Reparacion -> Float
presupuestoReparacion (Reparacion descripcion _) = (*3). genericLength $ descripcion

-- PUNTO 6 ======================================================

hacerUnaReparacion :: Plomero -> Reparacion -> Plomero
hacerUnaReparacion unPlomero unaReparacion
    | puedeReparar unaReparacion unPlomero = agregaReparacion unaReparacion . aumentarDinero (presupuestoReparacion unaReparacion) $ unPlomero 
    | otherwise = aumentarDinero 100 unPlomero


puedeReparar :: Reparacion -> Plomero -> Bool
puedeReparar unaReparacion unPlomero = requerimiento unaReparacion unPlomero || esMalvado unPlomero && tieneHerramienta martillo unPlomero

aumentarDinero :: Float -> Plomero -> Plomero
aumentarDinero unDinero = mapDinero (+ unDinero) 

agregaReparacion :: Reparacion -> Plomero -> Plomero
agregaReparacion unaReparacion unPlomero = unPlomero {historialReparaciones = unaReparacion : historialReparaciones unPlomero}

cambiaHerramientas :: Plomero -> Reparacion -> Plomero
cambiaHerramientas unPlomero unaReparacion
    | esMalvado unPlomero     = agregaHerramienta (Herramienta "Destornillador" 0 Plastico) unPlomero
    | esDificil unaReparacion = mapHerramienta (filter $ not.esBuenaHerramienta) unPlomero
    | otherwise               = mapHerramienta tail' unPlomero


tail' :: [a] -> [a]
tail' [] = []
tail' (x:xs) = xs