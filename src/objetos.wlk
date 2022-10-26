import wollok.game.*
import contrarios.*

object lionel {
	var property camiseta = "lionel-titular.png"
	var property position = game.at(2, 2)
	var property energia = 10
	var property pelotas = 0

	method image() {return camiseta}

	// Movimiento
	method subir() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != game.height() - 1) {
			position = position.up(1)
		}
	}

	method bajar() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != 0) {
			position = position.down(1)
		}
	}
	
	//
	method unTick(){
		//Polimorfismo
	}

}

object pelota {
	
	method newPelota(){
		const nuevo = new Pelota()
		game.addVisual(nuevo)
	}
	
}

class Pelota {

	const property image = "pelota.png"
	var property position = game.at(lionel.position().x(), lionel.position().y())

	method serPateada() {
		
	}
	
	//el contrario remueve el visual

}

