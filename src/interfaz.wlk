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
	}
	
	method colisioneCon(objeto) {
	}
	
	method colisionPelota(pelota){
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

object spawner {
	const property listaDeSpawneables = [gatorades, ingleses, alemanes, brasileros , bolsasDePelotas]
	
	method position(){return game.origin()}
	
	method unTick(){
		listaDeSpawneables.anyOne().agregarNuevo()
	}
}


