import wollok.game.*
import contrarios.*

object lionel {

	var property camiseta = "lionel-titular.png"
	var property position = game.at(1, 2)

	method image() {
		return camiseta
	}

	method patear() {
		pelota.pateada()
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
		game.removeTickEvent("pelotaEnMovimiento")
	}

	method hayVisualDeLaPelota() {
		return position.x() < game.width() and position.y().between(0, game.height())
	}

	method hayObstruccion() {
		return not game.colliders(self).isEmpty()
	}

	method validarPosition() {
		if (not ( self.position() == lionel.position() )) {
			self.error("la pelota no está en la misma posicion de lionel")
		}
	}

}

