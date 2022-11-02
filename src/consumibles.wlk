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
			position = position.left(1)
		} else {
			game.removeVisual(self)
		}
	}

	method unTick() {
		self.avanzar()
	}

	method colisionPelota(pelota) {
	// Polimorfismo
	}

	method colisioneCon(lionel)

}

//gatorades
object gatorades inherits Factory{

	override method nuevo() {
		return new Gatorade()
	}
	

}

class Gatorade inherits Consumible(image = "gatorade.png") {

	const property energia = 4

	override method colisioneCon(lionel) {
		lionel.energia(lionel.energia() + energia)
		game.removeVisual(self)
	}

}


//Bolsa De Pelotas
object bolsasDePelotas inherits Factory{

	override method nuevo() {
		return new BolsaDePelotas()
	}
}

class BolsaDePelotas inherits Consumible(image = "bolsaPelotas.jpg") {

	const property cantidad = 5

	override method colisioneCon(lionel) {
		lionel.cantidadDePelotas(lionel.cantidadDePelotas() + cantidad)
		game.removeVisual(self)
	}

}

