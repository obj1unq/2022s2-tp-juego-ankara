import wollok.game.*

class Jugador{
	var property image = null
	var property position = null
	const property ataque = null
	
	method unTick(){
		self.avanzar()
	}
	
	method avanzar() {
		position = position.left(1)
	}
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

object contrarios inherits Factory {
	
	override method nuevo() {
		return  new Contrario()
	}
	
}

object ingles inherits Factory{

	override method nuevo() {
		return  new Ingles()
	}
	
}
class Ingles inherits Jugador(image="lionel-titular.png") {
	
}


class Contrario inherits Jugador(image="aleman.png", ataque = 2) {

	//var property image = "aleman.png"
	//const property ataque = 2

	

	method colisioneCon(objeto) {
		objeto.energia(objeto.energia() - ataque)
	}
	
	method colisionPelota(pelota){
		game.removeVisual(self)
		game.removeVisual(pelota)
		game.removeTickEvent(pelota.nombreDeEvento())
	}

}

