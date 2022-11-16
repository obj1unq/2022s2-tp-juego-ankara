import wollok.game.*
import objetos.*
import contrarios.*
import consumibles.*

object visorEnergia {

	method position() {
		return game.at(1, game.height() - 0.5)
	}

	method text() {
		return "Energía: " + lionel.energia()
	}

	method textColor() {
		return "000000"
	}

	method unTick() {
	}

}

object visorPelotas {

	method position() {
		return game.at(3, game.height() - 0.5)
	}

	method text() {
		return "Pelotas: " + lionel.cantidadDePelotas()
	}

	method textColor() {
		return "000000"
	}

	method unTick() {
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

