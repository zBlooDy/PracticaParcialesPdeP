-- DATAS ======================================================

data Plomero = Plomero {
    nombre :: String,
    cajaDeHerramientas :: [Herramienta],
    historialReparaciones :: Int,
    cantidadDinero :: Int
} deriving (Show,Eq)

data Herramienta = Herramienta {
    denominacion :: String,
    precio :: Int,
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