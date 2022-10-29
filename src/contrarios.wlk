import wollok.game.*

class Jugador {

	var property image = null
	var property position = null
	const property ataque = null

	method unTick() {
		self.avanzar()
	}

	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(personaje) {
		personaje.serDebilitadoPor(self)
	}

	method colisionPelota(pelota) {
		game.removeVisual(self)
		game.removeVisual(pelota)
		game.removeTickEvent(pelota.nombreDeEvento())
	}

	method accionEspecial()

}

class Factory {

	method newPosition() {
		return game.at(19, (0 .. 4).anyOne())
	}

	method agregarNuevo() {
		const nuevo = self.nuevo()
		nuevo.position(self.newPosition())
		game.addVisual(nuevo)
	}

	method nuevo()

}

object alemanes inherits Factory {

	override method nuevo() {
		return new JugadorAleman()
	}

}

object ingleses inherits Factory {

	override method nuevo() {
		return new JugadorIngles()
	}

}

class JugadorIngles inherits Jugador(image = "ingles.png", ataque = 3) {


	override method accionEspecial() {
	}

}

class JugadorAleman inherits Jugador(image = "aleman.png", ataque = 5) {


	override method accionEspecial() {
	}

}

object brasileros inherits Factory {

	override method nuevo() {
		return new JugadorBrasilero()
	}

}

class JugadorBrasilero inherits Jugador(image = "brasilero.png", ataque = 20) {

	override method accionEspecial() {
	}

}

