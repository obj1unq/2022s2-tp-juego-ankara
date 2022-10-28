import wollok.game.*

object gatorades {

	method agregarNuevo() {
		const nuevo = new Gatorade()
		game.addVisual(nuevo)
	}

}

class Gatorade {

	var property image = "gatorade.png"
	var property position = game.at(19, (0 .. 5).anyOne())
	const property energia = 4

	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(lionel) {
		lionel.energia(lionel.energia() + energia)
		game.removeVisual(self)
	}
	
	method unTick(){
		position = position.left(1)
	}
	
	method colisionPelota(pelota){
		//Polimorfismo
	}

}

object bolsasDePelotas {

	method agregarNuevo() {
		const nuevo = new BolsaDePelotas()
		game.addVisual(nuevo)
	}

}

class BolsaDePelotas {

	var property image = "bolsaPelotas.jpg"
	var property position = game.at(19, (0 .. 5).anyOne())
	const property cantidad = 5

	method unTick() {
		position = position.left(1)
	}

	method colisioneCon(lionel) {
		lionel.cantidadDePelotas(lionel.cantidadDePelotas() + cantidad)
		game.removeVisual(self)
	}
	
	method colisionPelota(pelota){
		//Polimorfismo
	}
}

