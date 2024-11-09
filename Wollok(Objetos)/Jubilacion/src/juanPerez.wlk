object juanPerez {
    const companieros = []

    method invitadosParaLaFiesta() = companieros.filter {unCompaniero => unCompaniero.estaInvitado()}

    method numeroInvitados() = self.invitadosParaLaFiesta().size()
}