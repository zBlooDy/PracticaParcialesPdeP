import Distribution.Simple.Program.HcPkg (list)

-----------
--Parte 1--
-----------

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