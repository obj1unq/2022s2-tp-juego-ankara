import wollok.game.*
import consumibles.*
import interfaz.*

class Jugador {

	var property position = null

	method image()

	method ataque() {
		return 3
	}

	method unTick() {
		self.avanzar()
	}

	method dentroDelTablero() {
		return position.x() > 0
	}

	method avanzar() {
		if (self.dentroDelTablero()) {
			self.accionEspecial()
			position = position.left(1)
		} else {
			self.serEliminado()
		}
	}

	method colisionarConContrario(contrario) {
	// Polimorfismo
	}

	method colisioneCon(elemento) {
		elemento.colisionarConContrario(self)
	}

	method serEliminado() {
		game.removeVisual(self)
	}

	method accionEspecial()

	method colisionarConConsumible(consumible) {
	// no hace nada polimorfismo
	}

}

//Ingleses
class JugadorIngles inherits Jugador {

	var property debeSubir = false

	override method image() {
		return "ingles.png"
	}

	override method accionEspecial() {
		if (debeSubir) {
			self.subir()
		} else {
			self.bajar()
		}
		debeSubir = !debeSubir
	}

	method subir() {
		position = position.up(1)
	// No le agrego ninguna validación porque siempre empieza bajando
	}

	method bajar() {
		if (position.y() == 0) {
			debeSubir = !debeSubir
			self.accionEspecial()
			debeSubir = !debeSubir
		} else {
			position = position.down(1)
		}
	}

}

object ingleses inherits Factory {

	override method nuevo() {
		return new JugadorIngles()
	}

}

//Alemanes
class JugadorAleman inherits Jugador {

	override method image() {
		return "aleman.png"
	}

	override method ataque() {
		return 5
	}

	override method accionEspecial() {
	}

}

object alemanes inherits Factory {

	override method nuevo() {
		return new JugadorAleman()
	}

}

//Brazucas
class JugadorBrasilero inherits JugadorAleman {

	override method image() {
		return "brasilero.png"
	}

	override method ataque() {
		return 20
	}

}

object brasileros inherits Factory {

	override method nuevo() {
		return new JugadorBrasilero()
	}

}

