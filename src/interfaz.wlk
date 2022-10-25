import wollok.game.*
import objetos.*

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
	
	method colisioneCon(character) {
		//Evita errores.
	}

}

object visorPelotas {

	method position() {
		return game.at(3, game.height() - 0.5)
	}

	method text() {
		return "Pelotas: " + lionel.pelotas()
	}

	method textColor() {
		return "000000"
	}

	method colisioneCon(character) {
		//Evita errores.
	}
	
}

