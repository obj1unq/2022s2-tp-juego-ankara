import wollok.game.*
import contrarios.*

object lionel {
	var property camiseta = "messi.png"
	var property position = game.at(2, 2)
	var property energia = 10
	var property cantidadDePelotas = 0

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

	method unTick(){
		//Polimorfismo
	}
	
	method patearPelota(){
		pelotas.agregarNuevo()
	}
}


object pelotas {
	const property image = "pelota.png"
	method position() {return lionel.position() }
	
	method agregarNuevo(){
		if(lionel.cantidadDePelotas() > 0){
			const nuevo = new Pelota()
			game.addVisual(nuevo)
			nuevo.serPateada()
		}			
	}
	
	method unTick(){
		//Polimorfismo
	}
	
	method colisioneCon(lionel) {
		//Polimorfismo
	}
	
	method colisionPelota(){
	}
	
}

class Pelota {

	const property image = "pelota.png"
	var property position = game.at(lionel.position().x() +1 , lionel.position().y())

	method serPateada() {
		game.onTick(100, self.nombreDeEvento() , {self.moverse()})
	}
	
	method moverse(){
		game.colliders(self).forEach{ o => o.colisionPelota(self)}
		position = position.right(1)
		if(position.x() > game.width()){
			game.removeTickEvent(self.nombreDeEvento())
			game.removeVisual(self)
		}
	}
	
	method unTick(){
	}
	
	method colisionPelota(pelota){
	}
	
	method nombreDeEvento(){
		return "movimiento_pelota" + self.identity()
	}
	
	//el contrario remueve el visual

}

