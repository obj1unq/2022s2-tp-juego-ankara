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

	method colisioneCon(objeto) {
	}

	method colisionPelota(pelota) {
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

	method colisioneCon(objeto) {
	}

	method colisionPelota(pelota) {
	}

}

object administradorDeVisuales {

	const consumibles = [ bolsasDePelotas, gatorades ]
	const contrarios = [ alemanes, ingleses, brasileros ]
	var contrariosAgregadosPorConsumible = 0
	//
	var ultimoY = 0
	const posiblesPosiciones = [ 1, 2, 3, 4 ]

	method position() {
		return game.at(1, game.height() - 0.5)
	}

	method randomY() {
		return posiblesPosiciones.anyOne()
	}

	method newPosition() {
		return game.at(19, self.randomY())
	}

	method agregarConsumible(posicion) {
		consumibles.anyOne().agregarNuevo(posicion)
	}

	method agregarContrario(posicion) {
		contrarios.anyOne().agregarNuevo(posicion)
	}

	method unTick() {
		const nuevaPosicion = self.newPosition()
		posiblesPosiciones.add(ultimoY)
		if (contrariosAgregadosPorConsumible < 5) {
			self.agregarContrario(nuevaPosicion)
			contrariosAgregadosPorConsumible++
		} else {
			self.agregarConsumible(nuevaPosicion)
			contrariosAgregadosPorConsumible = 0
		}
		ultimoY = nuevaPosicion.y()
		posiblesPosiciones.remove(ultimoY)
	}

	method colisioneCon(objeto) {
	}

	method colisionPelota(pelota) {
	}

}

