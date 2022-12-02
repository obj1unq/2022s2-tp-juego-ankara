import wollok.game.*
import interfaz.*

class Consumible {

	var property image = null
	var property position = null

	method dentroDelTablero() {
		return position.x() > 0
	}

	method avanzar() {
		if (self.dentroDelTablero()) {
			position = position.left(1.50)
		} else {
			game.removeVisual(self)
		}
	}

	method unTick() {
		self.avanzar()	
	}

	method colisioneCon(elemento) {
		elemento.colisionarConConsumible(self)
	}

	method serConsumidoPor(personaje) {
		self.afectarA(personaje)
		game.removeVisual(self)
	}

	method afectarA(personaje)

}

class Factory {

	method agregarNuevo(position) {
		const nuevo = self.nuevo()
		nuevo.position(position)
		game.addVisual(nuevo)
	}

	method nuevo()

}

//gatorades
object gatorades inherits Factory {

	override method nuevo() {
		return new Gatorade()
	}

}

class Gatorade inherits Consumible(image = "gatorade.png") {

	const property energia = 4

	override method afectarA(personaje) {
		personaje.aumentarEnergia(energia)
	}
	
	override method colisioneCon(elemento){
		super(elemento)
	}

}

//Bolsa De Pelotas
object bolsasDePelotas inherits Factory {

	override method nuevo() {
		return new BolsaDePelotas()
	}

}

class BolsaDePelotas inherits Consumible(image = "bolsaPelotas.png") {

	const property cantidad = 3

	override method afectarA(personaje) {
		personaje.aumentarPelotas(cantidad)
	}

}

