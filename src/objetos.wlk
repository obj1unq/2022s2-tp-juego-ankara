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
		}
	}

	method bajar() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != 0) {
			position = position.down(1)
		}
	}

	method patear() {
		pelota.pateada()
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

}

object pelota {

	const property image = "pelota.png"
	var property position = game.at(1, 2)

	method pateada() {
		self.validarPosition()
		self.moverLaPelota_VecesALaDerecha(1)
		game.onTick(19, "pelotaEnMovimiento", { self.moverLaPelota_VecesALaDerechaSiHayVisualYNoHayObstruccion(1)})
	}

	method moverLaPelota_VecesALaDerechaSiHayVisualYNoHayObstruccion(cantidadDeVeces) {
		if (self.hayVisualDeLaPelota() and not self.hayObstruccion()) {
			self.moverLaPelota_VecesALaDerecha(cantidadDeVeces)
		} else {
			self.pararMovimientoDeLaPelota()
		}
	}

	method moverLaPelota_VecesALaDerecha(cantidadDeVeces) {
		position = position.right(cantidadDeVeces)
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

	method validarPosition() {
		if (not ( self.position() == lionel.position() )) {
			self.error("la pelota no está en la misma posicion de lionel")
		}
	}

}

