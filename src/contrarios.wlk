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
			self.accionEspecial()
			position = position.left(1)
		} else {
			self.serEliminado()
		}
	}
	
	method colisionarConContrario(contrario){
		//Polimorfismo
	}

	method colisioneCon(elemento) {
		elemento.colisionarConContrario(self)
	}

	method serEliminado() {
		game.removeVisual(self)
	}

	method accionEspecial()

}

//Ingleses
class JugadorIngles inherits Jugador(image = "ingles.png", ataque = 3) {
	var property debeSubir = false
	
	override method accionEspecial() {
		if (debeSubir){
			self.subir()	
		}
		else{
			self.bajar()
		}
		debeSubir = !debeSubir
	}
	
	
	method subir(){
		position = position.up(1)
		// No le agrego ninguna validación porque siempre empieza bajando
	}
	
	method bajar(){
		if (position.y() == 0){
			debeSubir = !debeSubir
			self.accionEspecial()
			debeSubir = !debeSubir
		} else{
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


