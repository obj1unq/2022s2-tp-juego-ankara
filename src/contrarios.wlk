import wollok.game.*
import consumibles.*
import interfaz.*

class Jugador {

	var property image = null
	var property position = null
	const property ataque = null

	method unTick() {
		self.avanzar()
	}

	method dentroDelTablero() {
		return position.x() > 0
	}

	method avanzar() {
		if (self.dentroDelTablero()) {
			position = position.left(1)
		} else {
			game.removeVisual(self)
		}
	}

	method colisioneCon(personaje) {
		personaje.serDebilitadoPor(self)
	}

	method colisionPelota(pelota) {
		game.removeVisual(self)
		pelota.removerse()
	}

	method accionEspecial()

}


class Factory {

	method agregarNuevo(position) {
		const nuevo = self.nuevo()
		nuevo.position(position)
		game.addVisual(nuevo)
	}

	method nuevo()

}


//Ingleses
class JugadorIngles inherits Jugador(image = "ingles.png", ataque = 3) {


	override method accionEspecial() {
	}
}

object ingleses inherits Factory {

	override method nuevo() {
		return new JugadorIngles()
	}
}

//Alemanes
class JugadorAleman inherits Jugador(image = "aleman.png", ataque = 5) {

	override method accionEspecial() {
	}
}

object alemanes inherits Factory {

	override method nuevo() {
		return new JugadorAleman()
	}
}

//Brazucas
class JugadorBrasilero inherits Jugador(image = "brasilero.png", ataque = 20) {

	override method accionEspecial() {
	}

}

object brasileros inherits Factory {

	override method nuevo() {
		return new JugadorBrasilero()
	}

}


