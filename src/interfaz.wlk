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
	
	method unTick(){
		contrarios.agregarNuevo()
		gatorades.agregarNuevo()
	}
	
	method colisioneCon(objeto) {
	}
	
	method colisionPelota(pelota){
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

	method unTick(){
		bolsasDePelotas.agregarNuevo()
	}
	
	method colisioneCon(objeto) {
	}
	
	method colisionPelota(pelota){
	}
	
}

