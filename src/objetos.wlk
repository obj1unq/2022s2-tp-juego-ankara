import wollok.game.*
import contrarios.*

object lionel {

	var property camiseta = "lionel-titular.png"
	var property position = game.at(2, 2)
	var property energia = 10

	var property cantidadDePelotas = 10
	var property score = 0


	method image() {
		return camiseta
	}

	// Movimiento
	method subir() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != campoDeJuego.height() - 1) {
			position = position.up(1)
		}
	}

	method bajar() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != 0) {
			position = position.down(1)
		}
	}

	method unTick() {
		if (not self.estaMuerto()){
			score += 10	
		}
	}

	method patearPelota() {
		if (cantidadDePelotas > 0) {
			pelotas.agregarNuevo()
			cantidadDePelotas -= 1
			game.sound("patada.mp3").play()
		}
	}

	method colisionarConContrario(contrario) {
		energia -= contrario.ataque()
		game.sound("nearmiss.mp3").play()
		if (self.estaMuerto()) {
			self.morir()
		}
	}

	method morir() {
		game.say(self, "Estoy muerto")
		camiseta = "lionel-muerto.png"
		game.sound("silbato.mp3").play()
		game.sound("no.mp3").play()
		game.sound("hinchada1.mp3").play()
		game.removeTickEvent("un_tick")
	}
	
	method estaMuerto(){
		return energia <= 0
	}

	method colisionarConConsumible(consumible) {
		consumible.serConsumidoPor(self)
	}

	method aumentarEnergia(cantidadDeEnergia) {
		energia += cantidadDeEnergia
	}

	method aumentarPelotas(nuevacantidadDePelotas) {
		cantidadDePelotas += nuevacantidadDePelotas
	}

}

object pelotas {

	const property image = "pelota.png"

	method position() {
		return lionel.position()
	}

	method agregarNuevo() {
		if (lionel.cantidadDePelotas() > 0) {
			const nuevo = new Pelota()
			game.addVisual(nuevo)
			nuevo.serPateada()
		}
	}

	method unTick() {
	// Polimorfismo
	}

	method colisioneCon(lionel) {
	// Polimorfismo
	}

}

class Pelota {

	const property image = "pelota.png"
	var property position = game.at(lionel.position().x() + 1, lionel.position().y())

	method serPateada() {
		game.onTick(conf.velocidad()/2, self.nombreDeEvento(), { self.moverse()})
		game.onCollideDo(self, { o => o.colisioneCon(self) })
	}

	method moverse() {
		position = position.right(1)
		if (position.x() > game.width()) {
			self.removerse()
		}
	}

	method unTick() {
	}

	method colisioneCon(elemento) {
	// polimorfismo
	}

	method colisionarConConsumible(consumible) {
	// polimorfismo
	}

	method colisionarConContrario(contrario) {
		contrario.serEliminado()
		self.removerse()
	}

	method nombreDeEvento() {
		return "movimiento_pelota" + self.identity()
	}

	method removerse() {
		game.removeVisual(self)
		game.removeTickEvent(self.nombreDeEvento())
	}

}

object conf{
	const property velocidad = 500
}

object campoDeJuego{
	const property height = 5

}

