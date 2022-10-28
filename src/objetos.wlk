import wollok.game.*
import contrarios.*

object lionel {

	var property camiseta = "lionel-titular.png"
	var property position = game.at(2, 2)
	var energia = 10
	var pelotas = 0

	method energia() {
		return energia
	}

	method pelotas() {
		return pelotas
	}

	method image() {
		return camiseta
	}

	method subir() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != game.height() - 1) {
			position = position.up(1)
			self.moverPelota()
		}
	}

	method bajar() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != 0) {
			position = position.down(1)
			self.moverPelota()
		}
	}
	
	method moverPelota(){
		if (pelota.llevandoPelota()){
			pelota.position(position)
		}
	}

	method patear() {
		if (pelota.llevandoPelota()){
			pelota.pateada()	
		}
	}

	method recibirEnergia(botella) {
		energia = energia + botella.energia()
		botella.serConsumida()
	}

	method recargarPelotas(bolsaDePelotas) {
		pelotas = pelotas + bolsaDePelotas.cantidad()
		bolsaDePelotas.serConsumida()
	}

	method serGolpeadoPor(contrario) {
		energia = energia - contrario.ataque()
	}
	
	method colisioneCon(character){
		// No hace nada.
	}

}

object pelota {

	const property image = "pelota.png"
	var property position = lionel.position()
	var property llevandoPelota = true

	method pateada() {
		// Le saco la validación. Lionel siempre debería tener la pelota antes que la patee.
		llevandoPelota = false
		self.moverDerecha()
		game.onTick(19, "pelotaEnMovimiento", { self.moverDerechaSiHayVisualYNoHayObstruccion()})
	}

	method moverDerechaSiHayVisualYNoHayObstruccion() {
		if (self.hayVisualDeLaPelota() and not self.hayObstruccion()) {
			self.moverDerecha()
		} else {
			self.pararMovimientoDeLaPelota()
		}
	}

	method moverDerecha() {
		position = position.right(1)
	}

	method pararMovimientoDeLaPelota() {
		game.removeTickEvent("pelotaEnMovimiento") // para la pelota cuando toca a alguien incluido lionel
	}

	method hayVisualDeLaPelota() {
		return position.x() < game.width() and position.y().between(0, game.height())
	}

	method hayObstruccion() {
		return not game.colliders(self).isEmpty() // indica si hay alguien en la misma posicion
	}

	method colisioneCon(character){
		// Para que no se rompa cuando colisionan lionel y pelota.
	}
	
	method serGolpeadoPor(contrario){
		if (position != lionel.position()){
			game.removeVisual(contrario)
		}
		
	}
	
	method recibirEnergia(botella) {
		// No hace nada
	}

	method recargarPelotas(bolsaDePelotas) {
		// No hace nada
	}
	
	// TODO: Descontar pelotas cada vez que la pateamos
	// TODO: Hacer que desaparezca la pelota cuando colisiona con un elemento.
	// TODO: Pelota tiene que ser una clase y que se vayan creando objetos a medida que patea.
	
	

}

