import wollok.game.*
import objetos.*
import contrarios.*
import consumibles.*

class Visor{
	method position()

	method text()

	method textColor() {
		return "000000"
	}
	method unTick() {
	}
}

object visorEnergia inherits Visor{

	override method position() {
		return game.at(1, game.height() - 0.5)
	}

	override method text() {
		return "Energía: " + lionel.energia()
	}
}

object visorPelotas inherits Visor {

	override method position() {
		return game.at(3, game.height() - 0.5)
	}

	override method text() {
		return "Pelotas: " + lionel.cantidadDePelotas()
	}
}

object visorScore inherits Visor{

	override method position() {
		return game.at(5, game.height() - 0.5)
	}

	override method text() {
		return "Score: " + lionel.score()
	}	
	method colisioneCon(objeto) {
	}

}

object spawner {

	const consumibles = [ bolsasDePelotas, gatorades ]
	const contrarios = [ alemanes, ingleses, brasileros ]
	var contrariosAgregadosPorConsumible = 0
	//
	const posicionInicialDeX = 19
	var ultimoPosicionDeY = null
	const posicionesDeYDelJuego = [ 0, 1, 2, 3, 4 ]

	method posicionesDeYPosibles() {
		return posicionesDeYDelJuego.copyWithout(ultimoPosicionDeY)
	}

	method position() {
		return game.origin()
	}

	method posicionRandomDeY() {
		return self.posicionesDeYPosibles().anyOne()
	}

	method newPosition() {
		return game.at(posicionInicialDeX, self.posicionRandomDeY())
	}

	method agregarConsumible(posicion) {
		consumibles.anyOne().agregarNuevo(posicion)
	}

	method agregarContrario(posicion) {
		contrarios.anyOne().agregarNuevo(posicion)
	}

	method unTick() {
		self.crearContrarioOConsumibleEn(self.newPosition())
	}

	method crearContrarioOConsumibleEn(posicion) {
		if (contrariosAgregadosPorConsumible < 5) {
			self.agregarContrario(posicion)
			contrariosAgregadosPorConsumible++
		} else {
			self.agregarConsumible(posicion)
			contrariosAgregadosPorConsumible = 0
		}
		self.guardarUltimaPosicionDeY(posicion)
	}

	method guardarUltimaPosicionDeY(posicion) {
		ultimoPosicionDeY = posicion.y()
	}

}

