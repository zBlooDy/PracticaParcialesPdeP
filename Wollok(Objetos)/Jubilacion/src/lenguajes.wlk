class Lenguaje {
    const antiguo

    method esViejo() = antiguo

    method esModerno() = ! self.esViejo() 
}

const wollokDodain = new Lenguaje(antiguo = false)