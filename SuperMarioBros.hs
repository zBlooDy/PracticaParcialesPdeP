-- DATAS ======================================================

data Plomero = Plomero {
    nombre :: String,
    cajaDeHerramientas :: [Herramienta],
    historialReparaciones :: Int,
    cantidadDinero :: Int
}

data Herramienta = Herramienta {
    denominacion :: String,
    precio :: Int,
    materialEmpuniadura :: Material
}

data Material = Hierro | Madera | Goma | Plastico


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

