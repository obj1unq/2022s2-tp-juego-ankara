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
		alemanes.agregarNuevo()
		gatorades.agregarNuevo()
		ingleses.agregarNuevo()
		brasileros.agregarNuevo()
	}
	
	method colisioneCon(objeto) {
	}
	
	method colisionPelota(pelota){
	}
	
	method unTick(){
		
	}
}

object factorys {
	const property listaDeSpawneables = [gatorades, contrarios, bolsasDePelotas]
	
	method position(){return game.origin()}
	
	method unTick(){
		listaDeSpawneables.anyOne().agregarNuevo()
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
	}
	
	method colisioneCon(objeto) {
	}
	
	method colisionPelota(pelota){
	}
}



