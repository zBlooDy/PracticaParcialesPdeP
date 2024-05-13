-- DATAS ======================================================
import Text.Show.Functions
import Data.List(genericLength)
import Data.Char(isUpper)

data Plomero = Plomero {
    nombre :: String,
    cajaDeHerramientas :: [Herramienta],
    historialReparaciones :: Int,
    cantidadDinero :: Float
} deriving (Show,Eq)

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
    historialReparaciones = 0,
    cantidadDinero = 1200
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