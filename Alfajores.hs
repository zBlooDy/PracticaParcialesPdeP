
---------------
----Parte 1----
---------------

data Alfajor = Alfajor {
    nombre :: String,
    dulzor :: Float,
    peso :: Float,
    relleno :: [Relleno]
}

data Relleno = DulceDeLeche | Mousse | Fruta deriving (Eq)


jorgito :: Alfajor
jorgito = Alfajor {
    nombre = "Jorgito",
    dulzor = 8,
    peso = 80,
    relleno = [DulceDeLeche]
}

havanna :: Alfajor
havanna = Alfajor {
    nombre = "Havanna",
    dulzor = 12,
    peso = 60,
    relleno = [Mousse, Mousse]
}

capitanDelEspacio :: Alfajor
capitanDelEspacio = Alfajor {
    nombre = "Capitan del espacio",
    dulzor = 12,
    peso = 40,
    relleno = [DulceDeLeche]
}


coeficienteDulzor :: Alfajor -> Float
coeficienteDulzor (Alfajor _ dulzor peso _) = dulzor / peso 

precioDeUnAlfajor :: Alfajor -> Float
precioDeUnAlfajor (Alfajor _ _ peso relleno) = 2 * peso  + precioRellenos relleno 

precioRellenos :: [Relleno] -> Float
precioRellenos listaRellenos = sum (map precioUnRelleno listaRellenos)

precioUnRelleno :: Relleno -> Float
precioUnRelleno unRelleno 
    | unRelleno == DulceDeLeche = 12
    | unRelleno == Mousse       = 15
    | otherwise                 = 10

esPotable :: Alfajor -> Bool
esPotable unAlfajor = (not. null . relleno $ unAlfajor) && todasCapasIguales (relleno unAlfajor) && (coeficienteDulzor unAlfajor >= 0.1)   

todasCapasIguales :: [Relleno] -> Bool
todasCapasIguales listaRellenos = all (head listaRellenos ==) listaRellenos



---------------
----Parte 2----
---------------

-- <- Abaratar -> 
abaratarAlfajor :: Alfajor -> Alfajor
abaratarAlfajor = reducirPeso 10 . bajarDulzor 7 

reducirPeso :: Float -> Alfajor -> Alfajor
reducirPeso unPeso = mapPeso (subtract unPeso)

mapPeso :: (Float -> Float) -> Alfajor -> Alfajor
mapPeso f unAlfajor = unAlfajor {peso = f $ peso unAlfajor}

bajarDulzor :: Float -> Alfajor -> Alfajor
bajarDulzor unDulzor = mapDulzor (subtract unDulzor)

mapDulzor :: (Float -> Float) -> Alfajor -> Alfajor
mapDulzor f unAlfajor = unAlfajor {dulzor = f $ dulzor unAlfajor}

-- <- Renombrar -> 
renombrarAlfajor :: String -> Alfajor -> Alfajor
renombrarAlfajor nuevoNombre = mapNombre (const nuevoNombre)

mapNombre :: (String -> String) -> Alfajor -> Alfajor
mapNombre f unAlfajor = unAlfajor {nombre = f $ nombre unAlfajor}

-- <- Agregar capa -> 
agregarCapaDeRelleno :: Relleno -> Alfajor -> Alfajor
agregarCapaDeRelleno unaCapa unAlfajor = unAlfajor {relleno = unaCapa : relleno unAlfajor}

-- <- Hacer Premium ->
hacerPremium :: Alfajor -> Alfajor
hacerPremium unAlfajor
    | esPotable unAlfajor = nombrePremium . agregarCapaDeRelleno (head.relleno $ unAlfajor) $ unAlfajor
    | otherwise           = unAlfajor

nombrePremium :: Alfajor -> Alfajor
nombrePremium = mapNombre (++ "premium")


hacerPremiumVariasVeces :: Int -> Alfajor -> Alfajor
hacerPremiumVariasVeces 0 unAlfajor = unAlfajor
hacerPremiumVariasVeces veces unAlfajor = hacerPremiumVariasVeces (veces-1) (hacerPremium unAlfajor)


jorgitito :: Alfajor
jorgitito = renombrarAlfajor "Jorgitito" . abaratarAlfajor $ jorgito

jorgelin :: Alfajor
jorgelin = renombrarAlfajor "Jorgelin" . agregarCapaDeRelleno DulceDeLeche $ jorgito

capitanDelEspacioCostaACosta :: Alfajor
capitanDelEspacioCostaACosta = renombrarAlfajor "Capitán del espacio de costa a costa" . hacerPremiumVariasVeces 4 . abaratarAlfajor $ capitanDelEspacio

