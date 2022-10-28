import wollok.game.*

object contrarios {
	
	method agregarNuevo() {
		const nuevo = new Contrario()
		game.addVisual(nuevo)
	}

}

class Contrario {

	var property image = "aleman.png"
	var property position = game.at(19, (0 .. 4).anyOne())
	const property ataque = 2

	method unTick(){
		self.avanzar()
	}
	
	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(objeto) {
		objeto.energia(objeto.energia() - ataque)
	}
	
	method colisionPelota(pelota){
		game.removeVisual(self)
		game.removeVisual(pelota)
		game.removeTickEvent(pelota.nombreDeEvento())
	}

}

