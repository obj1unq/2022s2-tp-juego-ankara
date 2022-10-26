import wollok.game.*

object gatoredes {

	method agregarNuevo() {
		const nuevo = new Gatorade()
		game.addVisual(nuevo)
	}

}

class Gatorade {

	var property image = "gatorade.png"
	var property position = game.at(19, (0 .. 4).anyOne())
	const property energia = 4

	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(character) {
		character.recibirEnergia(self)
	}

	method serConsumida() {
		game.removeVisual(self)
	}

}

object bolsasDePelotas {

	method agregarNuevo() {
		const nuevo = new Bolsa()
		game.addVisual(nuevo)
	}

}

class BolsaDePelotas {

	var property image = "bolsaPelotas.jpg"
	var property position = game.at(19, (0 .. 4).anyOne())
	const property cantidad = 5

	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(character) {
		character.recargarPelotas(self)
	}

	method serConsumida() {
		game.removeVisual(self)
	}

}

